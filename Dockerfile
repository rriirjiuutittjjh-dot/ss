FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# ---- Clean up partial lists and update packages safely ----
RUN rm -rf /var/lib/apt/lists/partial* && \
    apt-get update && apt-get install -y --no-install-recommends \
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

# ---- Clean CMD without config generation ----
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
