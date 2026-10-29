# 📘 Deploy LUXE Fashion Store (React + Express + MySQL) lên AWS EC2 với Docker + CI/CD

Tài liệu này hiện thực đầy đủ file hướng dẫn *Deploy_Docker_AWS_Full* cho dự án LUXE:

- [x] Tạo EC2 trên AWS
- [x] SSH từ Windows với `.pem`
- [x] Cài Docker + Docker Compose
- [x] Deploy fullstack (React + Express + MySQL) bằng Docker Compose
- [x] Nginx reverse proxy `/api/**` → backend
- [x] Xử lý ENV build-time cho frontend
- [x] Seed database trong Docker
- [x] Kết nối MySQL bằng Workbench
- [x] CI/CD GitHub Actions tự deploy lên EC2

> **Khác biệt so với tài liệu gốc** (đã điều chỉnh cho đúng dự án LUXE):
>
> | Tài liệu gốc | Dự án LUXE |
> | --- | --- |
> | 2 repo `uda_cloud_backend`, `uda_cloud_frontend` | 1 repo (monorepo) chứa `backend/`, `frontend/`, `database/` |
> | React CRA, biến `REACT_APP_*`, output `build/` | React **Vite**, biến `VITE_*`, output `dist/` |
> | Backend cổng `8080`, mở ra Internet | Backend cổng `5000`, chỉ bind `127.0.0.1` (đi qua Nginx) |
> | Mật khẩu/secret ghi thẳng trong `docker-compose.yml` | Tất cả nằm trong `.env` (không commit) |
> | `docker-compose` standalone | `docker compose` (plugin) — cài cả 2, lệnh nào cũng chạy |
> | CD `needs: ci-build` nhưng CI chỉ chạy khi PR ⇒ CD **luôn bị skip** | CI chạy cả PR lẫn push, CD chạy sau CI khi push `main` |
> | `CREATE USER 'root'@'%'` (lỗi vì image MySQL đã tạo sẵn) | Script tạo user riêng cho Workbench |
> | Không có swap | Tạo swap 2GB để build không bị OOM trên t2/t3.micro |

---

## 0. Tổng quan kiến trúc

**Stack:**

- **Frontend:** React (Vite) build → Nginx serve static
- **Backend:** Node.js + Express (`PORT=5000`)
- **Database:** MySQL 8 (chạy trong Docker, volume `luxe_mysql_data`)
- **Orchestrator:** Docker Compose
- **Reverse proxy:** Nginx trong container frontend, proxy `/api/**` → `backend:5000`

**Luồng request:**

```text
Client (browser)
       ↓
http://EC2_PUBLIC_IP/          → Nginx (luxe-frontend:80) → React SPA
http://EC2_PUBLIC_IP/api/**    → Nginx (luxe-frontend)   → luxe-backend:5000/api/**
luxe-backend:5000              → MySQL (host: mysql, port 3306)
MySQL Workbench (máy bạn)      → EC2_PUBLIC_IP:3306 → luxe-mysql
```

**Cấu trúc repo:**

```text
luxe-cicd/
├── .github/workflows/
│   ├── backend-ci-cd.yml        # CI/CD backend (mục 14.3)
│   ├── frontend-ci-cd.yml       # CI/CD frontend (mục 14.4)
│   └── docker-publish.yml       # Phương án B: Docker Hub (chạy tay)
├── backend/                     # API Express + mysql2 (src/routes: products, categories, auth, orders, admin)
├── frontend/                    # React 18 + Vite + Tailwind v4, Nginx (mục 7, 8)
│   └── public/images/products/  # 279 ảnh sản phẩm (webp, đặt tên theo slug)
├── database/
│   ├── init/01-schema.sql       # tạo bảng (users, categories, products, reviews, orders, order_items)
│   ├── init/02-seed.sql         # FILE TỰ SINH: 15 danh mục, 100 sản phẩm, 431 đánh giá, 2 tài khoản
│   └── seed/                    # catalog.js (dữ liệu gốc) + generate.js (sinh 02-seed.sql)
├── scripts/
│   ├── fix-pem-permission.ps1   # Windows: sửa quyền .pem + SSH (mục 3)
│   ├── install-docker.sh        # EC2: cài Docker + Compose (mục 4)
│   ├── ec2-setup.sh             # EC2: swap + Docker + tạo .env (mục 4, 5)
│   ├── seed-db.sh               # EC2: seed lại DB
│   ├── mysql-remote-user.sh     # EC2: tạo user cho Workbench (mục 11)
│   └── setup-github-actions-key.sh  # EC2: SSH key cho GitHub Actions (mục 14.1)
├── docker-compose.yml           # orchestrate toàn stack (mục 9)
├── docker-compose.prod.yml      # Phương án B
├── .env.example                 # mẫu biến môi trường
├── .gitattributes               # ép LF cho file .sh/.sql/.yml (commit từ Windows)
└── .gitignore
```

> Đã có đầy đủ source code. Chạy thử ở máy local: `cp .env.example .env` (đổi mật khẩu) rồi
> `docker compose up -d --build`, mở `http://localhost`.
>
> **Sửa dữ liệu sản phẩm:** sửa `database/seed/catalog.js` → `cd backend && npm install && cd ..`
> → `node database/seed/generate.js` → commit cả `02-seed.sql` → trên server `bash scripts/seed-db.sh`.

---

## 1. Chuẩn bị GitHub & source code

### 1.1. Yêu cầu với source code

**Backend** (`backend/`):

- `package.json` có script `"start"` (vd `"start": "node server.js"`).
- Lắng nghe cổng từ ENV: `const PORT = process.env.PORT || 5000;`
- Mọi route API bắt đầu bằng `/api` (vd `/api/products`).
- Kết nối MySQL bằng các biến ENV mà docker-compose truyền vào:

  ```js
  // ví dụ với mysql2
  const pool = mysql.createPool({
    host: process.env.DB_HOST,         // "mysql" (tên service), KHÔNG phải localhost
    port: process.env.DB_PORT,         // 3306
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });
  ```


**Frontend** (`frontend/`):

- Gọi API dạng `` `${import.meta.env.VITE_API_URL}/api/...` `` (hoặc axios `baseURL: import.meta.env.VITE_API_URL`).
- `VITE_API_URL` để **trống** ⇒ gọi `/api/...` cùng domain, Nginx proxy sang backend (không cần CORS).

### 1.2. Tạo repo GitHub và push

Trên máy Windows (thư mục `luxe-cicd`):

```bash
git init
git add .
git commit -m "Initial commit: LUXE fullstack + Docker + CI/CD"
git branch -M main
git remote add origin https://github.com/<github-user>/luxe-cicd.git
git push -u origin main
```

> Repo **private**: EC2 cần quyền `git clone/pull`. Cách đơn giản: tạo *Deploy key* —
> trên EC2 chạy `ssh-keygen -t ed25519 -f ~/.ssh/deploy_key -N ""`, dán `~/.ssh/deploy_key.pub`
> vào GitHub repo → **Settings → Deploy keys → Add** (chỉ Read), rồi clone bằng URL SSH
> `git@github.com:<github-user>/luxe-cicd.git` với `~/.ssh/config`:
>
> ```text
> Host github.com
>   IdentityFile ~/.ssh/deploy_key
> ```

---

## 2. Tạo EC2 trên AWS

### 2.1. Đăng nhập & chọn Region

- Truy cập **AWS Console**.
- Góc trên bên phải chọn Region gần VN: **Asia Pacific (Singapore) – `ap-southeast-1`**.

### 2.2. Tạo EC2 instance

1. **EC2 → Instances → Launch instances**
2. **Name:** `luxe-server`
3. **AMI:** `Ubuntu Server 22.04 LTS` hoặc `24.04 LTS` (Free tier eligible)
4. **Instance type:**
   - Dev/test: `t3.micro` / `t2.micro` (1GB RAM — **bắt buộc có swap**, script mục 4 tự tạo)
   - Mượt hơn: `t3.small` (2GB), `t3.medium` (4GB)
5. **Key pair → Create new key pair:**
   - Name: `luxe` — Type: `RSA` — Format: `.pem`
   - Tải `luxe.pem` về, vd `D:\keys\luxe.pem` (**không** để trong thư mục repo)
6. **Network settings → Security group (Create security group):**

   | Type | Port | Source | Ghi chú |
   | --- | --- | --- | --- |
   | SSH | 22 | **My IP** | GitHub Actions cũng SSH vào — xem lưu ý bên dưới |
   | HTTP | 80 | Anywhere (0.0.0.0/0) | Website |
   | MYSQL/Aurora | 3306 | **My IP** | Workbench (tài liệu gốc để Anywhere — không an toàn) |

   > ⚠️ GitHub Actions runner có IP thay đổi liên tục. Nếu SSH chỉ cho "My IP" thì bước CD sẽ
   > timeout. Với bài lab, đặt SSH = `Anywhere` (vẫn an toàn vì chỉ đăng nhập được bằng key,
   > không có mật khẩu). Môi trường thật nên dùng self-hosted runner hoặc AWS SSM.

7. **Storage:** tối thiểu 8GB gp3, khuyến nghị **20GB** (image Node + MySQL + cache build).
8. **Launch instance.**

> Sau khi tạo xong, lấy **Public IPv4** (vd `13.250.10.20`).
> Nên gắn **Elastic IP** (EC2 → Elastic IPs → Allocate → Associate) để IP không đổi khi stop/start —
> nếu không, mỗi lần đổi IP phải sửa secret `EC2_HOST`.

---

## 3. SSH từ Windows vào EC2 với file `.pem`

OpenSSH trên Windows từ chối key nếu file `.pem` cho phép user khác đọc
(`WARNING: UNPROTECTED PRIVATE KEY FILE!`). Chạy script có sẵn (PowerShell, tại thư mục repo):

```powershell
powershell -ExecutionPolicy Bypass -File scripts\fix-pem-permission.ps1 -PemPath "D:\keys\luxe.pem" -Ec2Ip 13.250.10.20
```

Hoặc chạy tay đúng như tài liệu:

```powershell
icacls "D:\keys\luxe.pem" /reset
icacls "D:\keys\luxe.pem" /inheritance:r
icacls "D:\keys\luxe.pem" /remove "NT AUTHORITY\Authenticated Users"
icacls "D:\keys\luxe.pem" /remove "BUILTIN\Administrators"
icacls "D:\keys\luxe.pem" /remove "BUILTIN\Users"
icacls "D:\keys\luxe.pem" /remove "NT AUTHORITY\SYSTEM"
icacls "D:\keys\luxe.pem" /grant:r "$($env:USERNAME):(R)"
icacls "D:\keys\luxe.pem"
ssh -i "D:\keys\luxe.pem" ubuntu@13.250.10.20
```

> Username mặc định của Ubuntu AMI: **`ubuntu`**.

---

## 4 + 5. Clone project & cài Docker trên EC2

Trong EC2 (user `ubuntu`):

```bash
cd ~
git clone https://github.com/<github-user>/luxe-cicd.git luxe
bash ~/luxe/scripts/ec2-setup.sh
```

`ec2-setup.sh` sẽ:

1. Tạo **swap 2GB** (`free -h` để xem).
2. Gọi `install-docker.sh`: thêm repo Docker chính thức, cài `docker-ce`, `docker compose` plugin,
   bản standalone `docker-compose`, bật service, và `usermod -aG docker ubuntu` (mục 14.2).
3. Tạo `~/luxe/.env` từ `.env.example` với **mật khẩu MySQL, JWT_SECRET ngẫu nhiên** và `FRONTEND_URL=http://<IP>`.

Sau đó **bắt buộc logout** để group `docker` có hiệu lực:

```bash
exit
```

SSH lại rồi kiểm tra:

```bash
groups                    # phải có chữ: docker
docker --version
docker compose version
docker-compose --version
docker ps                 # không lỗi permission denied là OK
cat ~/luxe/.env           # xem/sửa mật khẩu nếu muốn: nano ~/luxe/.env
```

Cấu trúc trên EC2:

```text
/home/ubuntu/luxe
  ├── backend/
  ├── frontend/
  ├── database/init/
  ├── docker-compose.yml
  └── .env               # chỉ tồn tại trên EC2, không có trên GitHub
```

---

## 6. Dockerfile backend

File [`backend/Dockerfile`](backend/Dockerfile):

- `node:22-alpine`, copy `package*.json` trước để cache layer `npm install`.
- Có `package-lock.json` ⇒ `npm ci --omit=dev`, không có ⇒ `npm install --omit=dev`.
- `npm run build --if-present`: tự build nếu backend là TypeScript
  (khi đó bỏ `--omit=dev` để có `typescript`).
- `EXPOSE 5000`, chạy `npm start`.

## 7. Dockerfile frontend (Vite + Nginx + ENV build-time)

File [`frontend/Dockerfile`](frontend/Dockerfile), multi-stage:

1. **Build stage** (`node:22-alpine`): nhận `ARG VITE_API_URL` → `ENV VITE_API_URL=$VITE_API_URL` → `npm run build` → `dist/`.
2. **Serve stage** (`nginx:1.27-alpine`): copy `dist/` vào `/usr/share/nginx/html`, render
   `nginx.conf.template` bằng `envsubst` với `PORT`, `BACKEND_URL` mỗi lần container start.

### 🔶 React và ENV build-time (phần quan trọng nhất)

- ❗ React (CRA lẫn Vite) **không đọc ENV ở runtime** — code chạy trên trình duyệt, không có `process.env`.
- ✔ Biến `VITE_*` (CRA: `REACT_APP_*`) chỉ được đọc lúc **`npm run build`** và thay thẳng vào file JS.
- ⇒ `environment:` của service frontend trong docker-compose **KHÔNG có tác dụng** với React
  (ở đây nó chỉ dùng cho Nginx: `PORT`, `BACKEND_URL`).
- ⇒ Muốn React dùng ENV trong Docker phải truyền qua **build args**:

  ```dockerfile
  ARG VITE_XXX
  ENV VITE_XXX=$VITE_XXX
  ```

  ```yaml
  frontend:
    build:
      args:
        VITE_XXX: ${VITE_XXX}
  ```

- Đổi giá trị biến ⇒ phải **build lại** image frontend (`docker compose build frontend`).

**Thêm biến mới** (vd Firebase): thêm cặp `ARG/ENV VITE_FIREBASE_API_KEY` vào Dockerfile, thêm
`VITE_FIREBASE_API_KEY: ${VITE_FIREBASE_API_KEY}` vào `build.args` trong `docker-compose.yml`,
thêm giá trị vào `~/luxe/.env`, và thêm `env:` tương ứng ở bước *Build React App* trong `frontend-ci-cd.yml`.
Trong code dùng `import.meta.env.VITE_FIREBASE_API_KEY`.

## 8. Nginx reverse proxy (frontend → backend)

File [`frontend/nginx.conf.template`](frontend/nginx.conf.template):

| Location | Tác dụng |
| --- | --- |
| `location ^~ /api/` | `proxy_pass http://backend:5000` (giữ nguyên `/api/...`), set header `Host`, `X-Real-IP`, `X-Forwarded-*` |
| `location /` | `try_files $uri $uri/ /index.html` — React Router reload trang con không bị 404 |
| `location ~* \.(js\|css\|png...)$` | cache file tĩnh 7 ngày |

Thêm so với tài liệu: `resolver 127.0.0.11` (Nginx không crash khi backend đang restart),
`client_max_body_size 10m` (upload ảnh), `gzip`, và `^~` để ảnh dạng `/api/uploads/x.png` không bị
location static bắt nhầm.

## 9. docker-compose.yml (orchestrate toàn stack)

File [`docker-compose.yml`](docker-compose.yml) gồm 3 service trên network `app-network`:

| Service | Container | Cổng | Ghi chú |
| --- | --- | --- | --- |
| `mysql` | `luxe-mysql` | `3306` (public, cho Workbench) | volume `mysql_data`, mount `./database/init` để seed, healthcheck `mysqladmin ping` |
| `backend` | `luxe-backend` | `127.0.0.1:5000` | `depends_on: mysql (service_healthy)`, ENV `DB_HOST=mysql`... |
| `frontend` | `luxe-frontend` | `80` | build args `VITE_API_URL`, Nginx proxy `/api/` |

Toàn bộ giá trị nhạy cảm lấy từ `.env`:

| Biến | Ý nghĩa |
| --- | --- |
| `MYSQL_ROOT_PASSWORD` | mật khẩu root MySQL |
| `MYSQL_DATABASE` / `MYSQL_USER` / `MYSQL_PASSWORD` | DB + user app (backend dùng) |
| `MYSQL_BIND` | `0.0.0.0` mở 3306 cho Workbench, `127.0.0.1` để đóng |
| `JWT_SECRET` | secret ký token |
| `FRONTEND_URL` | `http://<IP EC2>` |
| `FRONTEND_PORT` | `80` (local có thể đặt `3000`) |
| `VITE_API_URL` | để trống |

---

## 10. Chạy hệ thống với Docker Compose

Trên EC2:

```bash
cd ~/luxe
docker compose up -d --build        # lần đầu ~5–15 phút trên t3.micro
docker compose ps                   # 3 container: luxe-mysql (healthy), luxe-backend, luxe-frontend
```

Kiểm tra backend (trực tiếp và qua Nginx):

```bash
curl http://localhost:5000/api/health      # {"status":"ok","db":"up",...}
curl http://localhost/api/health           # qua Nginx — phải ra cùng kết quả
curl "http://localhost/api/products?limit=2"
```

Kiểm tra frontend:

```bash
curl -I http://localhost            # HTTP/1.1 200 OK
curl http://localhost | head        # HTML của React App
```

Trên máy bạn mở trình duyệt: `http://<EC2_PUBLIC_IP>/`

Xem log khi có lỗi:

```bash
docker compose logs -f backend
docker compose logs --tail=100 mysql
docker compose logs frontend
```

---

## 10.1. Seed database trong Docker

**Tự động:** lần đầu MySQL khởi động với volume trống, nó chạy lần lượt các file trong
`database/init/` (đã mount vào `/docker-entrypoint-initdb.d`):

- `01-schema.sql` — tạo bảng `users`, `categories`, `products`, `reviews`, `orders`, `order_items` (utf8mb4).
- `02-seed.sql` — 15 danh mục, 100 sản phẩm, 431 đánh giá, 2 tài khoản demo (UPSERT, chạy lại không trùng).

> ⚠️ Nếu EC2 đã từng chạy bản cũ (schema cũ thiếu cột `images`, `rating`..., bảng `reviews`),
> phải khởi tạo lại DB một lần: `bash scripts/seed-db.sh --reset` (xoá dữ liệu cũ).

Kiểm tra:

```bash
source ~/luxe/.env
docker exec -it luxe-mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" -e "SHOW TABLES; SELECT id,name,price FROM products;"
```

**Seed lại thủ công** (vì `docker-entrypoint-initdb.d` chỉ chạy 1 lần):

```bash
cd ~/luxe
bash scripts/seed-db.sh            # chạy lại toàn bộ database/init/*.sql vào DB đang chạy
bash scripts/seed-db.sh --reset    # XOÁ volume và khởi tạo DB từ đầu (mất hết dữ liệu, có hỏi xác nhận)
```

Import 1 file SQL bất kỳ:

```bash
docker exec -i -e MYSQL_PWD="$MYSQL_ROOT_PASSWORD" luxe-mysql mysql -uroot "$MYSQL_DATABASE" < backup.sql
```

Backup:

```bash
docker exec -e MYSQL_PWD="$MYSQL_ROOT_PASSWORD" luxe-mysql mysqldump -uroot "$MYSQL_DATABASE" > backup_$(date +%F).sql
```

> Tài khoản seed sẵn: **admin@luxe.vn / Admin@123** (vào `/admin`) và **demo@luxe.vn / Demo@123**.
> 🔐 Trên server public hãy đổi mật khẩu admin ngay (hoặc nâng quyền tài khoản của bạn trong trang
> Admin → Người dùng rồi hạ quyền `admin@luxe.vn`).

---

## 10.2. Sao lưu & khôi phục database

**Tự động:** workflow [`.github/workflows/db-backup.yml`](.github/workflows/db-backup.yml) chạy mỗi đêm
lúc **02:00 giờ Việt Nam**, dump MySQL thành `~/backups/luxe_YYYY-MM-DD_HHMM.sql.gz` trên EC2 và giữ **7 bản** mới nhất.
Sao lưu ngay: tab **Actions** → **Database Backup** → **Run workflow**.

Khôi phục một bản sao lưu (trên EC2):

```bash
cd ~/luxe && source .env
ls -lh ~/backups                                   # chọn file cần khôi phục
zcat ~/backups/luxe_2026-10-30_0200.sql.gz |   docker exec -i -e MYSQL_PWD="$MYSQL_ROOT_PASSWORD" luxe-mysql mysql -uroot "$MYSQL_DATABASE"
```

> Bản sao lưu nằm trên cùng máy EC2: xoá máy (Terminate) là mất cả bản sao lưu. Muốn an toàn hơn thì tải về máy:
> `scp -i luxe-ec2.pem ubuntu@<EC2_IP>:~/backups/<file>.sql.gz .`

---

## 11. Cho phép MySQL connect từ Workbench

### 11.1. Mở port 3306 trong Security Group

EC2 → **Security Groups** → chọn SG của instance → **Edit inbound rules** → thêm:

| Type | Port | Source |
| --- | --- | --- |
| MYSQL/Aurora | 3306 | **My IP** |

Trong `~/luxe/.env` giữ `MYSQL_BIND=0.0.0.0` (mặc định).

### 11.2. Tạo user remote cho MySQL

Image `mysql:8.0` **đã có sẵn `'root'@'%'`**, nên lệnh `CREATE USER 'root'@'%'` trong tài liệu gốc sẽ lỗi
`ERROR 1396 Operation CREATE USER failed`. Có 2 cách:

**Cách 1 — dùng luôn root** (mật khẩu = `MYSQL_ROOT_PASSWORD` trong `.env`). Kiểm tra:

```bash
source ~/luxe/.env
docker exec -it luxe-mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SELECT user,host FROM mysql.user;"
```

**Cách 2 (khuyến nghị) — tạo user riêng** chỉ có quyền trên DB `luxe_fashion`:

```bash
cd ~/luxe
bash scripts/mysql-remote-user.sh workbench 'MatKhauManh@2026'
```

Tương đương chạy tay:

```bash
docker exec -it luxe-mysql mysql -uroot -p
```

```sql
CREATE USER IF NOT EXISTS 'workbench'@'%' IDENTIFIED BY 'MatKhauManh@2026';
GRANT ALL PRIVILEGES ON luxe_fashion.* TO 'workbench'@'%';
FLUSH PRIVILEGES;
```

### 11.3. Kết nối bằng MySQL Workbench

**Cách A – trực tiếp (Standard TCP/IP):**

- Connection Method: `Standard (TCP/IP)`
- Hostname: `<EC2_PUBLIC_IP>` — Port: `3306`
- Username: `workbench` (hoặc `root`) — Password: *Store in Vault…*
- **Test Connection** → OK.

**Cách B – an toàn hơn (Standard TCP/IP over SSH)**, không cần mở 3306 ra Internet
(đặt `MYSQL_BIND=127.0.0.1` trong `.env`, chạy `docker compose up -d mysql`, xoá rule 3306):

- Connection Method: `Standard TCP/IP over SSH`
- SSH Hostname: `<EC2_PUBLIC_IP>:22` — SSH Username: `ubuntu` — SSH Key File: `D:\keys\luxe.pem`
- MySQL Hostname: `127.0.0.1` — Port: `3306` — Username/Password như trên.

---

## 12. Quy trình update code thủ công

Khi sửa code, push lên GitHub, rồi trên EC2:

```bash
cd ~/luxe
git pull
docker compose build backend        # thêm --no-cache nếu muốn build sạch hoàn toàn
docker compose build frontend
docker compose up -d                # chỉ recreate container có image mới
docker image prune -f               # dọn image cũ
```

> Với CI/CD bên dưới, bước này chạy **tự động** khi merge vào `main`.

---

# 🚀 13. CI/CD Pipeline triển khai tự động lên AWS EC2

Push code → GitHub Actions build & test → SSH vào EC2 → `git pull` → `docker compose build` → `up -d`.

- **CI (Continuous Integration):** chạy khi tạo Pull Request vào `main` (và chạy lại trước mỗi lần deploy).
- **CD (Continuous Deployment):** chạy khi push/merge vào `main`, chỉ sau khi CI pass.
- **Kết nối GitHub ↔ EC2** bằng SSH key.

## 13.1. Tạo SSH key cho GitHub Actions

👉 Thực hiện bằng **user triển khai `ubuntu`**, **không dùng root**.

```bash
ssh -i "D:\keys\luxe.pem" ubuntu@<EC2_PUBLIC_IP>
whoami                                   # ubuntu
bash ~/luxe/scripts/setup-github-actions-key.sh
```

Script tự làm đúng các bước của tài liệu:

1. `ssh-keygen -t rsa -b 4096 -C "github-actions" -f ~/.ssh/github`
   — `~/.ssh/github` là **PRIVATE KEY** (đưa vào GitHub Secrets), `~/.ssh/github.pub` là **PUBLIC KEY**.
2. `cat ~/.ssh/github.pub >> ~/.ssh/authorized_keys` + `chmod 600`.
3. Test tự SSH vào chính EC2 bằng key mới.
4. In ra giá trị 3 secret cần tạo.

Chạy tay (tương đương):

```bash
ssh-keygen -t rsa -b 4096 -C "github-actions" -f ~/.ssh/github -N ""
cat ~/.ssh/github.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys ~/.ssh/github ~/.ssh/github.pub
ssh -i ~/.ssh/github ubuntu@localhost     # vào được là key OK
cat ~/.ssh/github                         # copy toàn bộ, kể cả dòng BEGIN/END
```

## 13.2. Thêm GitHub Secrets

GitHub repo → **Settings → Secrets and variables → Actions → New repository secret**:

| Secret | Giá trị |
| --- | --- |
| `EC2_HOST` | Public IP / Elastic IP EC2 |
| `EC2_USER` | `ubuntu` |
| `EC2_SSH_KEY` | toàn bộ nội dung `~/.ssh/github` |

Chỉ khi dùng **Phương án B** (Docker Hub) mới cần thêm: `DOCKER_USERNAME`, `DOCKER_PASSWORD` (Access token).

### Cổng SSH 22 không mở cho cả Internet

Security Group chỉ cho SSH từ IP quản trị. Khi deploy, workflow đăng nhập AWS bằng **OIDC**
(không lưu access key), mở cổng 22 cho đúng IP của runner rồi **luôn đóng lại** sau khi xong.
Cần thêm 2 **Variables** (Settings → Secrets and variables → Actions → tab *Variables*):

| Variable | Giá trị |
| --- | --- |
| `AWS_ROLE_ARN` | ARN IAM role `luxe-github-deploy` — trust OIDC `token.actions.githubusercontent.com`, chỉ cho `sub` của repo + nhánh main. Repo mới dùng dạng immutable: `repo:<user>@<user_id>/luxe-cicd@<repo_id>:ref:refs/heads/main` (xem bằng `gh api repos/<user>/luxe-cicd/actions/oidc/customization/sub`) |
| `AWS_SG_ID` | ID Security Group của EC2 (vd `sg-0abc...`) |

Quyền của role chỉ gồm `ec2:AuthorizeSecurityGroupIngress` và `ec2:RevokeSecurityGroupIngress`
trên đúng Security Group đó.

## 13.3. Cấp quyền Docker cho user `ubuntu`

Đã làm trong `install-docker.sh` (`sudo usermod -aG docker ubuntu`). Kiểm tra lại sau khi SSH lại:

```bash
groups        # ubuntu adm ... sudo docker ...
docker ps     # không lỗi là thành công
```

Nếu chưa có: `sudo usermod -aG docker ubuntu`, `exit`, SSH lại.

## 13.4. CI/CD Backend — [`.github/workflows/backend-ci-cd.yml`](.github/workflows/backend-ci-cd.yml)

Kích hoạt khi thay đổi `backend/**`, `database/**`, `docker-compose.yml`:

| Job | Khi nào | Các bước |
| --- | --- | --- |
| `ci-build` | PR + push `main` | checkout → Node 22 → `npm ci` → `npm run build --if-present` → `npm test --if-present` → `docker build` |
| `cd-deploy` | push `main`, sau khi `ci-build` pass | SSH EC2: `cd ~/luxe && git pull --ff-only` → `docker compose build backend` → `up -d mysql backend` → `docker image prune -f` |

## 13.5. CI/CD Frontend — [`.github/workflows/frontend-ci-cd.yml`](.github/workflows/frontend-ci-cd.yml)

Kích hoạt khi thay đổi `frontend/**`:

| Job | Khi nào | Các bước |
| --- | --- | --- |
| `ci-build` | PR + push `main` | checkout → Node 22 → `npm ci` → `npm test --if-present` → `npm run build` → `docker build` |
| `cd-deploy` | push `main`, sau khi CI pass | SSH EC2: `git pull` → `docker compose build frontend` → `up -d frontend` → prune |

Cả 2 job deploy dùng chung `concurrency: deploy-ec2` nên khi một commit sửa cả backend lẫn frontend,
2 lần deploy chạy **lần lượt**, không giẫm lên nhau. Có thể deploy tay: tab **Actions** → chọn workflow → **Run workflow**.

## 13.6. Flow hoạt động

**🟢 1. Developer tạo Pull Request vào `main`**

```bash
git checkout -b feature/gio-hang
# ...sửa code...
git push -u origin feature/gio-hang     # rồi mở PR trên GitHub
```

- GitHub chạy **CI**: cài package, build, test, build thử Docker image.
- Nếu **FAIL ⇒ không nên merge**. Bật bắt buộc: **Settings → Branches → Add branch protection rule**
  → `main` → *Require status checks to pass* → chọn `CI – Build & Test Backend`, `CI – Build Frontend`.

**🔵 2. Merge vào `main`**

- CI chạy lại trên code đã merge → pass ⇒ **CD** SSH vào EC2 bằng private key.
- `git pull` → `docker compose build` → `docker compose up -d` → xoá image cũ.
- ⟹ **Hệ thống cập nhật hoàn toàn tự động**, xem tiến trình ở tab **Actions**.

## 13.7. Xử lý lỗi thường gặp

| Lỗi | Nguyên nhân / Cách sửa |
| --- | --- |
| Tạo SSH key bằng **root** ⇒ CD không vào được | `sudo -i -u ubuntu`, `cd ~`, chạy lại `bash ~/luxe/scripts/setup-github-actions-key.sh`, cập nhật secret `EC2_SSH_KEY` |
| `ssh: handshake failed` / `unable to authenticate` | Secret `EC2_SSH_KEY` thiếu dòng `-----BEGIN/END-----` hoặc sai user; `EC2_USER` phải là `ubuntu` |
| `dial tcp ...:22: i/o timeout` | Security Group SSH đang để "My IP" — runner GitHub không vào được (xem mục 2.2) hoặc `EC2_HOST` sai sau khi IP đổi |
| `permission denied ... docker.sock` | User chưa trong group docker: `sudo usermod -aG docker ubuntu` rồi logout/SSH lại |
| `git pull` lỗi `Not possible to fast-forward` | Có người sửa file trực tiếp trên EC2. `cd ~/luxe && git status`, rồi `git reset --hard origin/main` (`.env` không bị ảnh hưởng vì không được track) |
| `$'\r': command not found` khi chạy `.sh` | File bị CRLF (sửa trên Windows). `.gitattributes` đã ép LF; với file đã commit trước đó: `git add --renormalize . && git commit` |
| Build bị `Killed` / EC2 treo | Hết RAM: kiểm tra swap `free -h` (chạy lại `ec2-setup.sh`), hoặc nâng `t3.small`, hoặc dùng **Phương án B** |
| Backend `ECONNREFUSED 127.0.0.1:3306` | Backend đang dùng `localhost`; phải dùng `process.env.DB_HOST` (= `mysql`) |
| Backend `ER_ACCESS_DENIED` sau khi đổi mật khẩu trong `.env` | MySQL chỉ đọc `MYSQL_*` ở lần khởi tạo đầu. Đổi lại bằng `ALTER USER` hoặc `bash scripts/seed-db.sh --reset` |
| Web trắng / gọi API 404 | Code frontend gọi `http://localhost:5000` cứng ⇒ đổi sang `import.meta.env.VITE_API_URL` + `/api/...`, build lại frontend |
| Reload trang con bị 404 | Kiểm tra `try_files ... /index.html` trong `nginx.conf.template` |
| Workbench không kết nối | SG chưa mở 3306 cho IP hiện tại của bạn; `MYSQL_BIND` đang là `127.0.0.1`; user chưa có host `%` |

---

## 14. Phương án B (tuỳ chọn): build trên GitHub, EC2 chỉ pull image

Dùng khi EC2 quá yếu để build. Workflow [`docker-publish.yml`](.github/workflows/docker-publish.yml)
build 2 image → push Docker Hub (`<user>/luxe-fashion-backend`, `luxe-fashion-frontend`, tag `latest` + `sha`)
→ SSH EC2 chạy `docker compose -f docker-compose.prod.yml pull && up -d`.

1. Tạo secret `DOCKER_USERNAME`, `DOCKER_PASSWORD` (Docker Hub → Account settings → Personal access tokens).
2. Thêm `DOCKER_USERNAME=...` vào `~/luxe/.env`.
3. Chuyển trên EC2: `docker compose down && docker compose -f docker-compose.prod.yml up -d`
   (dữ liệu MySQL giữ nguyên vì chung volume `luxe_mysql_data`).
4. Chạy tay ở tab Actions, hoặc thêm trigger `push` vào `docker-publish.yml` và bỏ `push` trong 2 workflow kia.

Rollback về một commit cũ:

```bash
cd ~/luxe
IMAGE_TAG=<commit-sha> docker compose -f docker-compose.prod.yml up -d
```

---

## 15. Chạy local trên Windows (Docker Desktop)

```bash
cp .env.example .env              # sửa mật khẩu; có thể đặt FRONTEND_PORT=3000
docker compose up -d --build
```

- Web: `http://localhost` (hoặc `:3000`) — API: `http://localhost:5000/api/...`
- MySQL: `localhost:3306` (Workbench, user `root` / `MYSQL_ROOT_PASSWORD`)
- Dừng: `docker compose down` — xoá cả dữ liệu: `docker compose down -v`

## Checklist bảo mật

- Không commit `.env`, `*.pem`, private key (đã có trong `.gitignore`).
- Đổi toàn bộ mật khẩu mẫu trong `.env.example` (`ec2-setup.sh` đã tự sinh ngẫu nhiên trên EC2).
- Port 3306 chỉ mở cho **My IP**, hoặc đóng hẳn và dùng Workbench qua SSH tunnel.
- Backend không mở ra Internet (bind `127.0.0.1`), mọi truy cập qua Nginx `/api/`.
- Stop EC2 khi không dùng để tránh tốn tiền. Lưu ý AWS tính phí mọi địa chỉ IPv4 public (kể cả Elastic IP,
  kể cả khi instance đã stop) — xong bài lab hãy *Release* Elastic IP và *Terminate* instance.
