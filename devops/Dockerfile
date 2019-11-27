# Ones Flutter CI 构建镜像 Dockerfile，基于ubuntu

FROM ubuntu:18.04

# Install all build tools.
RUN su && apt-get update && apt-get install -y git && \
    apt-get install -y curl && \
      apt-get install -y bash && \
      apt-get install -y openssh-client && \
      apt-get install -y  tar && \
      apt-get install -y  rsync && \
      apt-get install -y unzip

RUN  git clone https://github.com/flutter/flutter.git /usr/local/flutter -b master && /usr/local/flutter/bin/flutter doctor

# Fix ssh host key checking problem when use ssh to connect remote server
# ssh免密码登录，以及上传文件到远程服务器修复
RUN mkdir ~/.ssh && echo 'Host *\n\
      StrictHostKeyChecking no\n\
      UserKnownHostsFile=/dev/null\n'\
      > ~/.ssh/config

ENV FLUTTER_HOME=/usr/local/flutter
# 开发环境 部署服务器配置项
ENV DEV_ONLINE_HOST 119.23.130.213
ENV DEV_ONLINE_SSH_PORT 8022
ENV DEV_ONLINE_USER "ones-api"
ENV DEV_ONLINE_DATA_PATH "/data/app/web/project"

