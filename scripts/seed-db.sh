#!/bin/bash
# Seed (nạp) lại dữ liệu vào MySQL đang chạy trong Docker.
# File trong database/init chỉ tự chạy ở lần đầu tạo volume; dùng script này khi muốn
# chạy lại sau đó (vd: vừa thêm dữ liệu mẫu mới).
#
#   bash scripts/seed-db.sh            # chạy tất cả database/init/*.sql
#   bash scripts/seed-db.sh --reset    # XOÁ SẠCH volume MySQL rồi khởi tạo lại từ đầu (mất dữ liệu!)
#
# Chạy tại thư mục gốc dự án (nơi có docker-compose.yml và .env).
set -e

cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
  echo "Không tìm thấy .env — hãy copy từ .env.example trước." >&2
  exit 1
fi
set -a; . ./.env; set +a

if [ "$1" = "--reset" ]; then
  read -r -p "Xoá toàn bộ dữ liệu MySQL và seed lại từ đầu? Gõ 'yes' để tiếp tục: " ans
  [ "$ans" = "yes" ] || { echo "Đã huỷ."; exit 0; }
  # down -v xoá container + volume của project (chỉ có mysql_data)
  docker compose down -v
  docker compose up -d
  echo ">> MySQL đang khởi tạo lại và tự chạy database/init/*.sql"
  exit 0
fi

for f in database/init/*.sql; do
  echo ">> Đang chạy $f"
  docker exec -i -e MYSQL_PWD="$MYSQL_ROOT_PASSWORD" luxe-mysql \
    mysql -uroot --default-character-set=utf8mb4 "${MYSQL_DATABASE:-luxe_fashion}" < "$f"
done

echo ">> Seed xong. Kiểm tra:"
docker exec -e MYSQL_PWD="$MYSQL_ROOT_PASSWORD" luxe-mysql \
  mysql -uroot "${MYSQL_DATABASE:-luxe_fashion}" -e "SELECT COUNT(*) AS categories FROM categories; SELECT COUNT(*) AS products FROM products;"
