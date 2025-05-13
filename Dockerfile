FROM ubuntu:20.04

# 设置时区避免安装时的交互提示
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    tmux \
    libsdl2-2.0-0 \
    libsdl2-image-2.0-0 \
    lib32gcc1 \
    && rm -rf /var/lib/apt/lists/*

# 创建Terraria服务器目录
RUN mkdir -p /opt/terraria/worlds
WORKDIR /opt/terraria

# 设置Terraria服务器版本
ENV TERRARIA_VERSION=1449

# 下载并解压Terraria服务器
RUN wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VERSION}.zip \
    && unzip terraria-server-${TERRARIA_VERSION}.zip \
    && mv */Linux/* . \
    && chmod +x TerrariaServer.bin.x86_64 \
    && rm -rf terraria-server-${TERRARIA_VERSION}.zip 

# 设置默认环境变量
ENV WORLD_FILE="/opt/terraria/worlds/world.wld"
ENV WORLD_NAME="Docker世界"
ENV AUTOCREATE=1
ENV WORLD_SIZE=2
ENV DIFFICULTY=0
ENV MAX_PLAYERS=8
ENV SERVER_PORT=7777
ENV SERVER_PASSWORD=""
ENV MOTD="欢迎来到Docker部署的泰拉瑞亚服务器!"
ENV SEED=""
ENV SECURE=1

# 对外暴露Terraria默认端口
EXPOSE 7777

# 设置数据卷
VOLUME ["/opt/terraria/worlds"]

# 复制启动脚本
COPY start-server.sh /opt/terraria/
RUN chmod +x /opt/terraria/start-server.sh

# 启动服务器
ENTRYPOINT ["/opt/terraria/start-server.sh"]