#!/bin/sh
set -eu

# volume 初回で ~/.local が root 所有になりがちなので直す
sudo mkdir -p /home/node/.local
sudo chown -R node:node /home/node/.local

# WSLホスト側のzshrcをコンテナにコピー（存在する場合のみ）
# bind mountの代わりにpostCreateでコピーする方式
WSL_ZSHRC="/workspaces/$(basename $(pwd))/.devcontainer/zshrc"
if [ -f "$WSL_ZSHRC" ]; then
  cp "$WSL_ZSHRC" /home/node/.zshrc
  echo "zshrc copied from .devcontainer/zshrc"
else
  echo "skip: .devcontainer/zshrc not found, using default"
fi

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
