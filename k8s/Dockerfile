ARG VERSION=latest
FROM ubuntu:$VERSION
MAINTAINER riki <java_ljx@163.com>

RUN apt-get update && apt-get install -y curl \
&& curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list deb http://apt.kubernetes.io/ kubernetes-xenial main EOF && \
apt-get update
RUN apt-get install -y kubectl
