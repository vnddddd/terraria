#!/bin/bash

echo "=====================================
正在启动泰拉瑞亚服务器...
====================================="
echo "服务器参数:"
echo "世界名称: ${WORLD_NAME}"
echo "世界大小: ${WORLD_SIZE} (1=小, 2=中, 3=大)"
echo "难度: ${DIFFICULTY} (0=普通, 1=专家, 2=大师, 3=旅行)"
echo "最大玩家数: ${MAX_PLAYERS}"
echo "端口: ${SERVER_PORT}"
echo "密码: ${SERVER_PASSWORD:-无}"
echo "====================================="

# 根据环境变量动态生成配置文件
echo "正在生成配置文件..."
cat > /opt/terraria/serverconfig.txt << EOL
# Terraria服务器配置
world=${WORLD_FILE}
autocreate=${AUTOCREATE}
worldname=${WORLD_NAME}
difficulty=${DIFFICULTY}
maxplayers=${MAX_PLAYERS}
port=${SERVER_PORT}
password=${SERVER_PASSWORD}
motd=${MOTD}
worldseed=${SEED}
secure=${SECURE}
worldsize=${WORLD_SIZE}
EOL

echo "配置文件生成完毕，启动服务器中..."
# 启动服务器
cd /opt/terraria
./TerrariaServer.bin.x86_64 -config /opt/terraria/serverconfig.txt