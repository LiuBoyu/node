FROM node:10.15.0-alpine

# 更新时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更新Alpine镜像源
#   阿里云VPC http://mirrors.cloud.aliyuncs.com （VPC内网高速免流量，用于云上自动构建）
#   阿里云    http://mirrors.aliyun.com （公网，用于本地手工构建）
#   Alpine   http://nl.alpinelinux.org （公网，用于 DockerHub 构建）
RUN apk update && apk upgrade \
 && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
 && echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories

RUN apk add --no-cache chromium@edge nss@edge harfbuzz@edge \
 && rm -rf /var/cache/apk/*

# 更新NPM镜像源 - 阿里云
RUN npm config set registry=https://registry.npm.taobao.org \
 && npm config set disturl=https://npm.taobao.org/dist

# 环境变量 - Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH '/usr/bin/chromium-browser'
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
