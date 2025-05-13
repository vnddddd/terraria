# 泰拉瑞亚服务器 Docker 镜像

这是一个用于部署泰拉瑞亚(Terraria)服务器的Docker镜像，支持通过环境变量进行完全配置。

## 功能特点

- 基于Ubuntu 20.04系统
- 自动下载并安装最新版本的Terraria服务器
- 完全通过环境变量配置服务器参数
- 持久化世界存储
- 简单易用的启动命令

## 快速开始

### 前提条件

- 安装了Docker的Linux/Windows/Mac系统
- 互联网连接以下载服务器文件

### 使用方法

#### 方法一：直接使用已发布的镜像

1. 拉取镜像：
```bash
docker pull caoxian088/terraria-server:latest
```

2. 启动服务器（使用默认设置）：
```bash
docker run -d -p 7777:7777 --name terraria -v terraria_worlds:/opt/terraria/worlds caoxian088/terraria-server:latest
```

#### 方法二：从源码构建

1. 克隆仓库：
```bash
git clone https://github.com/caoxian088/terraria-server-docker.git
cd terraria-server-docker
```

2. 构建Docker镜像：
```bash
docker build -t terraria-server .
```

3. 启动服务器：
```bash
docker run -d -p 7777:7777 --name terraria -v terraria_worlds:/opt/terraria/worlds terraria-server
```

4. 查看日志：
```bash
docker logs -f terraria
```

## 环境变量配置

您可以通过设置以下环境变量来自定义服务器配置：

| 环境变量 | 默认值 | 描述 |
|-------------|-------------------|-------------|
| WORLD_FILE | /opt/terraria/worlds/world.wld | 世界文件路径 |
| WORLD_NAME | Docker世界 | 世界名称 |
| AUTOCREATE | 1 | 自动创建世界（0=否，1=是） |
| WORLD_SIZE | 2 | 世界大小（1=小，2=中，3=大） |
| DIFFICULTY | 0 | 难度（0=普通，1=专家，2=大师，3=旅行） |
| MAX_PLAYERS | 8 | 最大玩家数量 |
| SERVER_PORT | 7777 | 服务器端口 |
| SERVER_PASSWORD |  | 服务器密码（留空表示无密码） |
| MOTD | 欢迎来到Docker部署的泰拉瑞亚服务器! | 欢迎信息 |
| SEED |  | 世界种子（留空表示随机） |
| SECURE | 1 | 服务器安全设置（0=关闭，1=开启，防止作弊和保障多人游戏安全） |

## 高级使用示例

### 创建自定义大型专家模式世界

```bash
docker run -d -p 7777:7777 --name terraria \
  -e WORLD_NAME="大型专家世界" \
  -e WORLD_SIZE=3 \
  -e DIFFICULTY=1 \
  -e MAX_PLAYERS=16 \
  -e SERVER_PASSWORD="secretpassword" \
  -e MOTD="欢迎来到专家模式服务器!" \
  -v terraria_worlds:/opt/terraria/worlds \
  caoxian088/terraria-server:latest
```

### 使用固定种子创建世界

```bash
docker run -d -p 7777:7777 --name terraria \
  -e WORLD_NAME="固定种子世界" \
  -e SEED="05162020" \
  -v terraria_worlds:/opt/terraria/worlds \
  caoxian088/terraria-server:latest
```

## 数据持久化

世界数据存储在Docker卷中。要备份您的世界，可以使用以下命令复制数据：

```bash
docker cp terraria:/opt/terraria/worlds /path/to/backup
```

## 网络配置

默认情况下，服务器使用7777端口。如果需要更改端口，请确保同时修改映射和环境变量：

```bash
docker run -d -p 8888:8888 --name terraria -e SERVER_PORT=8888 -v terraria_worlds:/opt/terraria/worlds caoxian088/terraria-server:latest
```

## 玩家连接

玩家可以通过以下方式连接到服务器：

1. 在Terraria游戏中选择"多人游戏"
2. 选择"通过IP连接"
3. 输入服务器IP地址和端口（默认7777）
4. 如果设置了密码，则需要输入密码

## 疑难解答

1. 如果遇到网络问题，可以尝试设置代理：


2. 如果服务器无法启动，请检查日志：
   ```bash
   docker logs terraria
   ```

3. 如果需要直接访问服务器控制台：
   ```bash
   docker attach terraria
   ```
   (使用Ctrl+P然后Ctrl+Q可以退出但不停止容器)

4. 如果服务器内存不足，可以增加容器内存限制：
   ```bash
   docker run -d -p 7777:7777 --name terraria -m 2G -v terraria_worlds:/opt/terraria/worlds caoxian088/terraria-server:latest
   ```

## 参考资料

- [官方Terraria Wiki - 建立泰拉瑞亚服务器](https://terraria.wiki.gg/zh/wiki/Guide:建立泰拉瑞亚服务器)
- [Terraria官方网站](https://terraria.org/)
- [Docker Hub镜像](https://hub.docker.com/r/caoxian088/terraria-server)

## 许可证

MIT 