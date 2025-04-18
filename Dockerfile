FROM ubuntu:20.04 as builder

RUN set -e && \
    apt-get update -q -y --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -q -y --no-install-recommends \
        git \
        build-essential \
        ca-certificates \
        cmake \
        libuv1-dev \
        libzmq3-dev \
        libsodium-dev \
        libpgm-dev \
        libnorm-dev \
        libgss-dev \
        libcurl4-openssl-dev

WORKDIR /usr/src

RUN git clone --recursive https://github.com/SChernykh/p2pool.git

WORKDIR /usr/src/p2pool

RUN git submodule update --init --recursive && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)


FROM ubuntu:20.04

COPY --from=builder /usr/src/p2pool/build/p2pool /

RUN set -e && \
    apt-get update -q -y --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -q -y --no-install-recommends \
        libzmq5 \
        libuv1 \
        libcurl4 \
      && apt-get clean

RUN groupadd -r p2pool -g 1000 && \
    useradd -u 1000 -r -g p2pool -s /sbin/nologin -c "p2pool user" p2pool && \
    mkdir -p /home/p2pool/.p2pool && \
    chown p2pool.p2pool /home/p2pool /home/p2pool/.p2pool

USER p2pool

EXPOSE 3333 37889 37888

VOLUME /home/p2pool/.p2pool

WORKDIR /home/p2pool/.p2pool
ENTRYPOINT ["/p2pool"]
