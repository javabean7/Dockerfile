ARG VERSION=latest
FROM ubuntu:$VERSION
MAINTAINER riki <java_ljx@163.com>

RUN apt-get install curl \
&& curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun \
&& apt-get update && apt-get install -y apt-transport-https && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list deb http://apt.kubernetes.io/ kubernetes-xenial main EOF && \
apt-get update && \
apt-get install -y kubectl
