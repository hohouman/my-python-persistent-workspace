#!/bin/bash

# 检查是否设置了用户名和密码
if [ -z "$WEB_USER" ] || [ -z "$WEB_PASSWORD" ]; then
    echo "❌ 错误: 必须设置 WEB_USER 和 WEB_PASSWORD 环境变量！"
    echo "   示例: docker run -e WEB_USER=admin -e WEB_PASSWORD=secret ..."
    exit 1
fi

echo "✅ Web 终端已启动，请访问端口 7681"
echo "🔐 认证用户: $WEB_USER"

# 启动 ttyd
# -c: 指定用户名:密码
# -W: 允许客户端写入
# exec: 替换当前 shell 进程，确保信号能正确传递
exec ttyd -c "${WEB_USER}:${WEB_PASSWORD}" -W -p 7681 tmux new -A -s workspace
