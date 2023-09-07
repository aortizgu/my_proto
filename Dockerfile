FROM ubuntu:22.04

LABEL maintainer="aortiz@gmail.com"
LABEL version="0.1"
LABEL description="This is custom Docker Image for the grpc example."

ENV TERM linux
ENV HOME /root

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y --no-install-recommends \
    autoconf \
    build-essential \
    libtool \
    g++ \
    git \
    clang \
    libgtest-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/Kitware/CMake/releases/download/v3.27.4/cmake-3.27.4-Linux-x86_64.sh \
    -q -O /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir /opt/cmake-3.27.4 \
    && /tmp/cmake-install.sh --skip-license --prefix=/opt/cmake-3.27.4 \
    && rm /tmp/cmake-install.sh \
    && ln -s /opt/cmake-3.27.4/bin/* /usr/local/bin

ENV GRPC_RELEASE_TAG v1.58.0
RUN echo "-- installing grpc" && \
    git clone --verbose -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /opt/grpc && \
    cd /opt/grpc && \
    git submodule update --init && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
    -DgRPC_INSTALL=ON \
    -DgRPC_PROTOBUF_PACKAGE_TYPE=CONFIG \
    -DgRPC_BUILD_TESTS=OFF \
    ../.. && \
    make -j$(nproc) && \
    make install

CMD ["/bin/bash"]