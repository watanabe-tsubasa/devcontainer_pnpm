#!/bin/sh
set -eu

# volume 初回で ~/.local が root 所有になりがちなので直す
sudo mkdir -p /home/node/.local
sudo chown -R node:node /home/node/.local

# pnpm（package.json があるときだけ）
pnpm -v
if [ -f package.json ]; then
  pnpm install
else
  echo "skip: package.json not found in $(pwd)"
fi

# claude（なければ入れる）
if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
