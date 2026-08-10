FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    sudo \
    docker.io \
    htop \
    btop \
    neovim \
    lsof \
    qemu-system \
    cloud-image-utils \
    && rm -rf /var/lib/apt/lists/*

# ---- Install code-server ----
RUN curl -fsSL https://code-server.dev/install.sh | sh

# ---- Download sshx binary safely (No execution during build) ----
RUN curl -fsSL https://github.com/ekzhang/sshx/releases/latest/download/sshx-x86_64-unknown-linux-musl.tar.gz | tar -xz -C /usr/local/bin

# ---- Workspace ----
WORKDIR /workspace

EXPOSE 7860

# Run both when the container starts up
CMD ["sh", "-c", "sshx & code-server --bind-addr 0.0.0.0:7860 --auth none"]
