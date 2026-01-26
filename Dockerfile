FROM python:3.9-slim

# 设置工作目录 (这也是你存放 .py 文件的目录)
WORKDIR /app

# 1. 安装系统依赖 (curl, tmux, nodejs)
# 2. 清理缓存
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    tmux \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# 安装 ttyd
RUN curl -L -o /usr/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 \
    && chmod +x /usr/bin/ttyd

# 安装 Python 库
RUN pip install --no-cache-dir \
    lxml==4.7.1 \
    PyExecJS==1.5.1 \
    requests==2.26.0 \
    schedule==1.1.0

# 复制启动脚本并赋予执行权限
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 暴露端口
EXPOSE 7681

# 设置容器启动时的入口点
ENTRYPOINT ["/entrypoint.sh"]
