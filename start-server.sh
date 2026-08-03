#!/bin/bash
# 番茄钟桌面浮窗 — 本地 HTTP 服务器启动脚本
# 用法：bash start-server.sh
# 通过 HTTP 方式打开看板，window.open 弹窗不会被拦截

PORT=8765
DIR="$(cd "$(dirname "$0")" && pwd)"

# 检查端口是否被占用
if lsof -i :$PORT &>/dev/null; then
  echo "端口 $PORT 已被占用，尝试关闭旧进程..."
  lsof -ti :$PORT | xargs kill -9 2>/dev/null
  sleep 0.5
fi

echo "启动本地服务器：http://localhost:$PORT"
cd "$DIR"
python3 -m http.server $PORT &
SERVER_PID=$!
sleep 1

# 自动打开浏览器
open "http://localhost:$PORT/进校增长-任务看板.html"

echo "浏览器已打开看板。关闭终端可停止服务器（PID: $SERVER_PID）"
echo "提示：开始番茄钟后浮窗会自动弹出到桌面。"
wait $SERVER_PID
