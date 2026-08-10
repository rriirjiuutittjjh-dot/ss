FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# ---- Create missing apt directories with correct permissions ----
RUN mkdir -p /var/lib/apt/lists/partial && \
    chmod -R 755 /var/lib/apt/lists

# ---- Install system utilities ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# ---- Set credentials during build time ----
RUN echo 'root:root' | chpasswd && \
    echo 'ubuntu:root' | chpasswd

# ---- Install JupyterLab ----
RUN pip3 install --no-cache-dir jupyterlab --break-system-packages

# ---- Workspace ----
WORKDIR /workspace

EXPOSE 8888

# Run JupyterLab and sshx
CMD ["bash", "-c", "curl -sSf https://sshx.io/get | sh -s run & exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser"]
