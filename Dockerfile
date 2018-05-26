ARG VERSION=latest
FROM ubuntu:$VERSION
MAINTAINER riki <java_ljx@163.com>
# basic stuff
RUN echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf \
    && apt-get update && apt-get install \
    bash \
    build-essential \
    dbus-x11 \
    fontconfig \
    gzip \
    language-pack-en-base \
    libgl1-mesa-glx \
    make \
    sudo \
    tar \
    unzip
# git
RUN apt-get update && apt-get install software-properties-common \
    && add-apt-repository ppa:git-core/ppa \
    && apt update \
    && apt install git \
    && git clone https://github.com/javabean7/.spacemacs.d.git /root/.spacemacs.d/ \
    && cd /root/.spacemacs.d && git checkout linux && cd /root \
    && cp -rf .spacemacs.d .emacs.d \
    && cd /root/.emacs.d && git checkout emacs3 && cd /root \
# su-exec
    && git clone https://github.com/ncopa/su-exec.git /tmp/su-exec \
    && cd /tmp/su-exec \
    && make \
    && chmod 770 su-exec \
    && mv ./su-exec /usr/local/sbin/ \
# Cleanup
    && apt-get purge build-essential \
    && apt-get autoremove \
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*
# Emacs
RUN apt-get update && apt-get install software-properties-common \
    && apt-add-repository ppa:kelleyk/emacs \
    && apt-get update && apt-get install emacs25
# fish
RUN apt-get install curl \
    && apt-add-repository ppa:fish-shell/release-2 \
    && apt-get update \
    && apt-get install fish \
#    && curl -L https://get.oh-my.fish | fish \
#    && fish install --path=~/.local/share/omf --config=~/.config/omf \
# docker
    && curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun \
    && curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
   && chmod +x /usr/local/bin/docker-compose \
#    && apt-get install docker-compose \
# Cleanup
    && apt-get purge software-properties-common \
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*

# other
RUN mkdir -p /etc/docker \
    && apt-get update && apt-get install htop \
    && apt-get install vim \
    && apt-get install silversearcher-ag \
    && apt-get install npm \
    && npm i -g npm \
    && npm i -g yarn \
    && npm i -g n \
    && apt-get install net-tools \
    && apt-get install iputils-ping \
    && n latest
