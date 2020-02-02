FROM yangby0cryptape/riscv-tools:rv64imac-newlib-20190829 AS builder
MAINTAINER Boyu Yang <yangby@cryptape.com>

FROM yangby0cryptape/ckb-build:bionic-rustc1.41.0
MAINTAINER Boyu Yang <yangby@cryptape.com>

COPY --from=builder "/opt/riscv" "/opt/riscv"

ENV RISCV="/opt/riscv"
ENV PATH="${PATH}:${RISCV}/bin"

# Install system packages
RUN set -eux; \
    apt-get update; \
    apt-get upgrade --assume-yes; \
    \
# for dependencies
    apt-get install --assume-yes --no-install-recommends \
    # both for riscv gnu toolchain and riscv tools
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
        \
    # only for riscv tools
        libusb-1.0-0-dev \
        device-tree-compiler \
        pkg-config \
        ; \
    \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;
