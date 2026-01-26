FROM python:3.9-slim

# 关键：定义构建参数，Docker Buildx 会自动填充这个值 (amd64 或 arm64)
ARG TARGETARCH

WORKDIR /app

# 安装基础依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    tmux \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# 关键逻辑：根据 CPU 架构下载对应的 ttyd
# 如果是 arm64，下载 ttyd.aarch64
# 否则默认下载 ttyd.x86_64
RUN echo "Building for architecture: $TARGETARCH" && \
    if [ "$TARGETARCH" = "arm64" ]; then \
        curl -L -o /usr/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.aarch64; \
    else \
        curl -L -o /usr/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64; \
    fi \
    && chmod +x /usr/bin/ttyd

# 安装 Python 库
RUN pip install --no-cache-dir \
    lxml==4.7.1 \
    PyExecJS==1.5.1 \
    requests==2.26.0 \
    schedule==1.1.0

# 复制之前的 entrypoint 脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7681
ENTRYPOINT ["/entrypoint.sh"]
