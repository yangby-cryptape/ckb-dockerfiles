FROM debian:buster-slim AS builder
MAINTAINER Boyu Yang <yangby@cryptape.com>

ENV RISCV_ARCH="rv64imac"
ENV RISCV_URL="https://github.com/nervosnetwork/ckb-riscv-gnu-toolchain.git"
ENV REVISION="2da9107e57be773cb3a5defa8eb764903375c4a6"
ENV CFLAGS_FOR_TARGET_EXTRA="-Os -DCKB_NO_MMU -D__riscv_soft_float -D__riscv_float_abi_soft"

# The install-prefix for executable files
ENV RISCV_HOME="/opt/riscv"
RUN set -eux; \
    mkdir -p "${RISCV_HOME}";

# Install system packages
RUN set -eux; \
    apt-get update; \
    apt-get upgrade --assume-yes; \
    \
# for dependencies
    apt-get install --assume-yes --no-install-recommends \
        autoconf \
        automake \
        autotools-dev \
        curl \
        libmpc-dev \
        libmpfr-dev \
        libgmp-dev \
        gawk \
        build-essential \
        bison \
        flex \
        texinfo \
        gperf \
        libtool \
        patchutils \
        bc \
        zlib1g-dev \
        libexpat-dev \
# for tools
        git \
        ca-certificates \
        ;

# Fetch source code of riscv gnu toolchain
RUN set -eux; \
    mkdir -p /usr/src/riscv-gnu-toolchain; \
    cd /usr/src/riscv-gnu-toolchain; \
    git init .; \
    git remote add origin "${RISCV_URL}"; \
    git fetch origin --depth=1 "${REVISION}"; \
    git reset --hard FETCH_HEAD

# Sync submodules
RUN set -eux; \
    cd /usr/src/riscv-gnu-toolchain; \
    git submodule update --init --recursive --recommend-shallow;

# Compile
RUN set -eux; \
    cd /usr/src/riscv-gnu-toolchain; \
    export CFLAGS_FOR_TARGET_EXTRA="${CFLAGS_FOR_TARGET_EXTRA}" \
    export MAKEFLAGS="-j$(($(nproc)+1))"; \
    ./configure --prefix="${RISCV_HOME}" --with-arch="${RISCV_ARCH}"; \
    make;

FROM debian:buster-slim
MAINTAINER Boyu Yang <yangby@cryptape.com>

COPY --from=builder "/opt/riscv" "/opt/riscv"

ENV RISCV_HOME="/opt/riscv"
ENV PATH="${PATH}:${RISCV_HOME}/bin"

# Install system packages
RUN set -eux; \
    apt-get update; \
    apt-get upgrade --assume-yes; \
    \
# for dependencies
    apt-get install --assume-yes --no-install-recommends \
        autoconf \
        automake \
        autotools-dev \
        curl \
        libmpc-dev \
        libmpfr-dev \
        libgmp-dev \
        gawk \
        build-essential \
        bison \
        flex \
        texinfo \
        gperf \
        libtool \
        patchutils \
        bc \
        zlib1g-dev \
        libexpat-dev \
        ; \
    \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

RUN set -eux; \
    mkdir -p /work; \
    chmod 777 /work;

WORKDIR /work
CMD ["riscv64-unknown-elf-gcc", "--version"]
