#!/bin/sh
# mvn打包服务 跳过测试
mvn package -DskipTests

# docker 镜像构建
docker build -t kkfile .

# 获取git的提交哈希作为tag
latest_commit_hash=$(git log --pretty=format:"%h" -n 1)
date=$(date +"%m-%d")

# docker 上传
docker login csighub.tencentyun.com/ci-docker/doc-kkfile
docker tag kkfile:latest csighub.tencentyun.com/ci-docker/doc-kkfile:$date-$latest_commit_hash
docker push csighub.tencentyun.com/ci-docker/doc-kkfile:$date-$latest_commit_hash
