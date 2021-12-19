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
    wget -O /tmp/gbdk.tar.gz https://github.com/gbdk-2020/gbdk-2020/releases/download/4.0.5/gbdk-linux64.tar.gz; \
    tar -xvf /tmp/gbdk.tar.gz -C /opt/;

RUN set -eux; \
    wget -O /tmp/rgbds.tar.gz https://github.com/gbdev/rgbds/archive/refs/tags/v0.5.2.tar.gz; \
    tar -xvf /tmp/rgbds.tar.gz -C /tmp/; \
    cd /tmp/rgbds-0.5.2; \
    make; \
    make install;

RUN set -eux; \
    curl https://raw.githubusercontent.com/asmotor/asmotor/master/bootstrap.sh | sh -s /usr/local;

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
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /tmp/*;

ENV GBDKDIR /opt/gbdk/
ENV PATH /opt/gbdk/bin:$PATH
