#!/bin/bash
# Tạo SSH key cho GitHub Actions SSH vào EC2 (mục 14.1).
# PHẢI chạy bằng user triển khai (ubuntu), KHÔNG dùng root:  bash setup-github-actions-key.sh
set -e

if [ "$(id -u)" -eq 0 ]; then
  echo "Đang là root! Chuyển sang user ubuntu: sudo -i -u ubuntu, rồi chạy lại." >&2
  exit 1
fi

mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ ! -f ~/.ssh/github ]; then
  ssh-keygen -t rsa -b 4096 -C "github-actions" -f ~/.ssh/github -N ""
fi

# Thêm public key vào authorized_keys (không thêm trùng)
touch ~/.ssh/authorized_keys
grep -qxF "$(cat ~/.ssh/github.pub)" ~/.ssh/authorized_keys || cat ~/.ssh/github.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys ~/.ssh/github ~/.ssh/github.pub

# Test: tự SSH vào chính máy này bằng key vừa tạo
if ssh -i ~/.ssh/github -o StrictHostKeyChecking=accept-new -o BatchMode=yes "$USER@localhost" 'echo ">> SSH key OK, user: $(whoami)"'; then
  :
else
  echo ">> Test SSH thất bại, kiểm tra lại ~/.ssh/authorized_keys" >&2
fi

echo
echo "================ Tạo 3 GitHub Secret (Settings → Secrets and variables → Actions) ================"
echo "EC2_HOST    = $(curl -fs --max-time 3 https://checkip.amazonaws.com || echo '<Public IP / Elastic IP của EC2>')"
echo "EC2_USER    = $USER"
echo "EC2_SSH_KEY = toàn bộ nội dung bên dưới (gồm cả dòng BEGIN/END):"
echo
cat ~/.ssh/github
