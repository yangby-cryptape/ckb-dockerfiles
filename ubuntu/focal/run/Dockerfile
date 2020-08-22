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
        libssl1.1 \
        ; \
    \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*;

# Default runtime environment
COPY entrypoint.sh "${INSTALL_PREFIX}/bin/"
RUN set -eux; \
    chmod +x "${INSTALL_PREFIX}/bin/entrypoint.sh";

WORKDIR /ckb
ENTRYPOINT ["entrypoint.sh"]
