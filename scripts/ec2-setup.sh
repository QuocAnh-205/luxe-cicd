#!/bin/bash
# Thiết lập EC2 lần đầu (chạy 1 lần, user ubuntu, KHÔNG dùng root), sau khi đã clone repo:
#   git clone https://github.com/<github-user>/<repo>.git ~/luxe
#   bash ~/luxe/scripts/ec2-setup.sh
#
# Script sẽ:
#   1. Tạo swap 2GB (t2/t3.micro chỉ có 1GB RAM, build React + MySQL dễ bị OOM)
#   2. Cài Docker + Docker Compose (install-docker.sh)
#   3. Tạo file ~/luxe/.env từ .env.example với mật khẩu/secret ngẫu nhiên
set -e

APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ---------- 1. Swap ----------
if ! swapon --show | grep -q /swapfile; then
  echo ">> Tạo swap 2GB"
  sudo fallocate -l 2G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab > /dev/null
fi
free -h

# ---------- 2. Docker ----------
if ! command -v docker > /dev/null; then
  bash "$APP_DIR/scripts/install-docker.sh"
fi

# ---------- 3. .env ----------
if [ ! -f "$APP_DIR/.env" ]; then
  cp "$APP_DIR/.env.example" "$APP_DIR/.env"
  PUBLIC_IP=$(curl -fs --max-time 3 https://checkip.amazonaws.com || echo localhost)
  sed -i \
    -e "s|^MYSQL_ROOT_PASSWORD=.*|MYSQL_ROOT_PASSWORD=$(openssl rand -hex 16)|" \
    -e "s|^MYSQL_PASSWORD=.*|MYSQL_PASSWORD=$(openssl rand -hex 16)|" \
    -e "s|^JWT_SECRET=.*|JWT_SECRET=$(openssl rand -hex 32)|" \
    -e "s|^FRONTEND_URL=.*|FRONTEND_URL=http://$PUBLIC_IP|" \
    "$APP_DIR/.env"
  chmod 600 "$APP_DIR/.env"
  echo ">> Đã tạo $APP_DIR/.env (xem mật khẩu MySQL bằng: cat $APP_DIR/.env)"
fi

echo ">> Xong. Bước tiếp theo:"
echo "   exit                       # logout để group docker có hiệu lực, rồi SSH lại"
echo "   cd $APP_DIR && docker compose up -d --build"
