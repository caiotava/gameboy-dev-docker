FROM debian:bullseye-slim

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gcc \
        g++ \
        make \
        cmake \
        pkg-config \
        bison \
        libpng-dev \
        wget \
        curl \
        git \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    wget -O /tmp/gbdk.tar.gz https://github.com/gbdk-2020/gbdk-2020/releases/download/4.1.1/gbdk-linux64.tar.gz; \
    tar -xvf /tmp/gbdk.tar.gz -C /opt/;

 RUN set -eux; \
    wget -O /tmp/rgbds.tar.gz https://github.com/gbdev/rgbds/releases/download/v0.6.1/rgbds-0.6.1.tar.gz; \
    tar -xvf /tmp/rgbds.tar.gz -C /tmp/; \
    cd /tmp/rgbds; \
    make; \
    make install;

RUN set -eux; \
    wget -O /tmp/png2gb.tar.gz https://github.com/LuckyLights/png2gb/archive/refs/heads/master.tar.gz; \
    tar -xvf /tmp/png2gb.tar.gz -C /tmp/; \
    cd /tmp/png2gb-master; \
    make; \
    make install;

RUN set -eux; \
    wget -O /tmp/bmp2cgb.tar.gz https://github.com/gitendo/bmp2cgb/archive/refs/heads/master.tar.gz; \
    tar -xvf /tmp/bmp2cgb.tar.gz -C /tmp/; \
    cd /tmp/bmp2cgb-master; \
    make; \
    cp bmp2cgb /usr/local/bin;

RUN set -eux; \
    wget -O /tmp/go.tgz "https://go.dev/dl/go1.20.1.linux-amd64.tar.gz" --progress=dot:giga; \
    tar -C /usr/local -xzf /tmp/go.tgz; \
    rm /tmp/go.tgz;

ENV GOPATH /usr/local/go/bin
ENV PATH $GOPATH:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN set -eux; \
    wget -O /tmp/gbdk-go.tar.gz https://github.com/caiotava/gbdk-go/archive/refs/heads/upgrate-to-use-new-gbdk-2020.tar.gz; \
    tar -xvf /tmp/gbdk-go.tar.gz -C /tmp/; \
    cd /tmp/gbdk-go-upgrate-to-use-new-gbdk-2020; \
    make build; \
    cp go2c gbdkgo /opt/gbdk/bin;

RUN set -eux; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /tmp/*;

ENV GBDKDIR /opt/gbdk/
ENV PATH /opt/gbdk/bin:$PATH
