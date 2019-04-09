FROM ubuntu:bionic

ENV RUST_VERSION="1.33.0"

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
        clang \
        libclang-dev \
        pkg-config \
        libssl-dev \
        ; \
    \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

# Install rust toolchain
ENV RUSTUP_HOME="${INSTALL_PREFIX}/local/rustup"
ENV CARGO_HOME="${INSTALL_PREFIX}/local/cargo"
ENV PATH "${PATH}:${CARGO_HOME}/bin"
RUN set -eux; \
    tmpDeps="curl"; \
    apt-get update; \
    apt-get install --assume-yes --no-install-recommends ${tmpDeps}; \
    \
    curl https://sh.rustup.rs -sSf \
        | sh -s -- -y --no-modify-path --default-toolchain "${RUST_VERSION}"; \
    rustup self update; \
    chmod -R a+w "${RUSTUP_HOME}" "${CARGO_HOME}"; \
    rustup --version; \
    cargo --version; \
    rustc --version; \
    \
    apt-get purge --assume-yes --autoremove ${tmpDeps}; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

# Install rust components
RUN set -eux; \
    rustup component add rustfmt --toolchain "${RUST_VERSION}"; \
    rustup component add clippy --toolchain "${RUST_VERSION}"; \
    rustfmt --version; \
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
