FROM ubuntu:focal
MAINTAINER Boyu Yang <yangby@cryptape.com>

# The install-prefix for third-party executable files
ENV INSTALL_PREFIX="/opt"
ENV PATH "${PATH}:${INSTALL_PREFIX}/bin"
RUN set -eux; \
    mkdir -p "${INSTALL_PREFIX}/bin";

# Install system packages
RUN set -eux; \
    apt-get update; \
    apt-get upgrade --assume-yes; \
# for basic tools
    apt-get install --assume-yes --no-install-recommends \
        gosu \
        sudo \
        ; \
    gosu nobody true; \
    echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers; \
    \
# for dependencies
    apt-get install --assume-yes --no-install-recommends \
        ca-certificates \
        make \
        clang \
        libclang-dev \
        pkg-config \
        libssl-dev \
        ; \
    \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

# Install rust toolchain
ENV RUSTUP_HOME="${INSTALL_PREFIX}/local/rustup" \
    CARGO_HOME="${INSTALL_PREFIX}/local/cargo" \
    RUSTUP_VERSION="1.22.1" \
    RUSTUP_SHA256="49c96f3f74be82f4752b8bffcf81961dea5e6e94ce1ccba94435f12e871c3bdb" \
    RUST_ARCH="x86_64-unknown-linux-gnu" \
    RUST_VERSION="1.47.0"
ENV PATH="${PATH}:${CARGO_HOME}/bin"
RUN set -eux; \
    tmpDeps="curl"; \
    apt-get update; \
    apt-get install --assume-yes --no-install-recommends ${tmpDeps}; \
    \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init"; \
    curl -sSf -O "${url}"; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain "${RUST_VERSION}"; \
    rm rustup-init; \
    rustup component add rustfmt --toolchain "${RUST_VERSION}"; \
    rustup component add clippy --toolchain "${RUST_VERSION}"; \
    chmod -R a+w "${RUSTUP_HOME}" "${CARGO_HOME}"; \
    \
    apt-get purge --assume-yes --autoremove ${tmpDeps}; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

# Check versions
RUN set -eux; \
    openssl version; \
    rustup --version; \
    cargo --version; \
    rustc --version; \
    cargo fmt --version; \
    cargo clippy --version;

# Default runtime environment
COPY entrypoint.sh "${INSTALL_PREFIX}/bin/"
RUN set -eux; \
    chmod +x "${INSTALL_PREFIX}/bin/entrypoint.sh"; \
    mkdir -p /ckb \
        "${CARGO_HOME}/registry" "${CARGO_HOME}/git"; \
    chmod 777 /ckb \
        "${CARGO_HOME}/registry" "${CARGO_HOME}/git";

WORKDIR /ckb
ENTRYPOINT ["entrypoint.sh"]
