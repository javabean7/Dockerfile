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

# pupeteer
RUN apt-get update && \
apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont \
ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget && \
wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
dpkg -i dumb-init_*.deb && rm -f dumb-init_*.deb && \
apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN yarn global add puppeteer@1.3.0 && yarn cache clean
