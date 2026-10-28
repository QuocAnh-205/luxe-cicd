#!/bin/bash
# Tạo user MySQL cho phép đăng nhập từ xa (MySQL Workbench) — mục 11/12.2 tài liệu.
# Chạy trên EC2 tại thư mục ~/luxe:
#   bash scripts/mysql-remote-user.sh workbench 'MatKhauManh@123'
#
# Lưu ý: image mysql:8.0 đã tạo sẵn 'root'@'%', nên lệnh CREATE USER 'root'@'%' trong
# tài liệu gốc sẽ báo lỗi "Operation CREATE USER failed". Nên tạo user riêng như script này.
set -e

cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

NEW_USER="${1:-workbench}"
NEW_PASS="$2"
if [ -z "$NEW_PASS" ]; then
  echo "Cách dùng: bash scripts/mysql-remote-user.sh <user> '<password>'" >&2
  exit 1
fi

docker exec -i -e MYSQL_PWD="$MYSQL_ROOT_PASSWORD" luxe-mysql mysql -uroot <<SQL
CREATE USER IF NOT EXISTS '${NEW_USER}'@'%' IDENTIFIED BY '${NEW_PASS}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE:-luxe_fashion}\`.* TO '${NEW_USER}'@'%';
FLUSH PRIVILEGES;
SELECT user, host FROM mysql.user;
SQL

echo ">> Đã tạo user '${NEW_USER}'@'%' — dùng trong MySQL Workbench: Host = IP EC2, Port = ${MYSQL_PUBLIC_PORT:-3306}"
