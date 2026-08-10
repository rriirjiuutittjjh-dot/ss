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
RUN curl -sSf https://sshx.io/get | sh -s run

# ---- Workspace ----
WORKDIR /workspace

CMD ["code-server", "--bind-addr", "--auth", "none"]
