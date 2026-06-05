#!/bin/sh
set -eu

# Ensure writable user dirs
sudo mkdir -p /home/node/.local /pnpm-store
sudo chown -R node:node /home/node/.local /pnpm-store

# Install devcontainer-specific zshrc
cp .devcontainer/zshrc /home/node/.zshrc
sudo chown node:node /home/node/.zshrc

# Prepare pnpm
corepack enable

# Install dependencies if package.json exists
if [ -f package.json ]; then
  pnpm -v
  pnpm install
else
  echo "skip: package.json not found in $(pwd)"
fi