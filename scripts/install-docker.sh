#!/bin/bash
# Cài Docker Engine + Docker Compose trên EC2 Ubuntu 22.04/24.04 (mục 4 tài liệu).
# Chạy bằng user ubuntu (KHÔNG dùng root):  bash install-docker.sh
set -e

sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release git

# Thêm GPG key + repo chính thức của Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
# docker-compose-plugin cung cấp lệnh `docker compose` (khuyến nghị)
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker

# Bản standalone `docker-compose` (có gạch nối) để chạy được các lệnh giống tài liệu gốc
sudo curl -fsSL "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Cho user hiện tại chạy docker không cần sudo (mục 14.2) — cần logout/SSH lại mới có hiệu lực
sudo usermod -aG docker "$USER"

docker --version
docker compose version
docker-compose --version
echo ">> Cài xong. Hãy 'exit' rồi SSH lại, sau đó chạy 'groups' phải thấy chữ docker."
