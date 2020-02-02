# [Unofficial] CKB Dockerfiles

Dockerfiles for [CKB].

## Dockers

All docker images can be found in [my page][my-docker-hub-url] at Docker Hub
Registry.

### CKB-Build

Build environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`bionic-rustc1.41.0`]

Start the docker as follows:

```bash
docker run --rm -it \
    --workdir "${DOCKER_DIR}" \
    --volume "${HOST_DIR}:${DOCKER_DIR}" \
    --volume "rust-registry:/opt/local/cargo/registry" \
    --volume "rust-git:/opt/local/cargo/git" \
    yangby0cryptape/ckb-build:bionic-rustc1.41.0 \
    ${COMMANDS}
```

Put the source codes of [CKB] in `${HOST_DIR}` in the host filesystem and mount
it as `workdir` (default is `/ckb`) in the docker container.

Use `volumes` for `/opt/local/cargo/registry` and `/opt/local/cargo/git` can
cache files to make `cargo` command faster.

### CKB-Dev

Development environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`bionic-rustc1.41.0-riscv20190829`]

Start the docker as follows:

```bash
docker run --rm -it \
    --workdir "${DOCKER_DIR}" \
    --volume "${HOST_DIR}:${DOCKER_DIR}" \
    --volume "rust-registry:/opt/local/cargo/registry" \
    --volume "rust-git:/opt/local/cargo/git" \
    yangby0cryptape/ckb-dev:bionic-rustc1.41.0-riscv20190829 \
    ${COMMANDS}
```

This docker is an enhanced version of `yangby0cryptape/ckb-build:xxx`.
It includes a [RISC-V development environment].

### CKB-Run

Runtime environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`bionic`]

Start the docker as follows:

```bash
docker run --rm -it \
    --workdir "${DOCKER_DIR}" \
    --volume "${HOST_DIR}:${DOCKER_DIR}" \
    yangby0cryptape/ckb-build:bionic \
    ${COMMANDS}
```

Put the executable file of [CKB] in `${HOST_DIR}` in the host filesystem and
mount it as `workdir` (default is `/ckb`) in the docker container.

[CKB]: https://github.com/nervosnetwork/ckb
[my-docker-hub-url]: https://hub.docker.com/u/yangby0cryptape/
[RISC-V development environment]: https://github.com/yangby-cryptape/riscv-dockerfiles
[`bionic-rustc1.41.0`]: https://github.com/yangby-cryptape/ckb-dockerfiles/tree/bionic-rustc1.41.0/ubuntu/bionic/build
[`bionic-rustc1.41.0-riscv20190829`]: https://github.com/yangby-cryptape/ckb-dockerfiles/tree/bionic-rustc1.41.0-riscv20190829/ubuntu/bionic/build
[`bionic`]: https://github.com/yangby-cryptape/ckb-dockerfiles/tree/master/ubuntu/bionic/run
