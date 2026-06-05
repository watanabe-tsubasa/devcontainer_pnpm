FROM node:22

# Install basic development tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends less man-db sudo git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Ensure default `node` user has access to `sudo`
ARG USERNAME=node
RUN echo "$USERNAME ALL=(root) NOPASSWD:ALL" > "/etc/sudoers.d/$USERNAME" \
    && chmod 0440 "/etc/sudoers.d/$USERNAME"

# Enable Corepack for pnpm/yarn
RUN corepack enable

# Install Pure prompt inside the container image, not from host dotfiles
RUN npm install -g pure-prompt

ENV DEVCONTAINER=true