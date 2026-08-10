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

# ---- Workspace ----
WORKDIR /workspace

EXPOSE 7860

# Download sshx and run both code-server and sshx safely when the container starts
CMD ["sh", "-c", "curl -sSf https://sshx.io/get | sh -s run & code-server --bind-addr 0.0.0.0:7860 --auth none"]
