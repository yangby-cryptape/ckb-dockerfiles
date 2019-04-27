# [Unofficial] CKB Dockerfiles

Dockerfiles for [CKB].

## Dockers

All docker images can be found in [my page][my-docker-hub-url] at Docker Hub
Registry.

### CKB-Build

Build environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`bionic-rustc1.34.1`]

Start the docker as follows:

```bash
docker run --rm -it \
    --workdir "${DOCKER_DIR}" \
    --volume "${HOST_DIR}:${DOCKER_DIR}" \
    --volume "rust-registry:/opt/local/cargo/registry" \
    --volume "rust-git:/opt/local/cargo/git" \
    yangby0cryptape/ckb-build:bionic-rustc1.34.1 \
    ${COMMANDS}
```

Put the source codes of [CKB] in `${HOST_DIR}` in the host filesystem and mount
it as `workdir` (default is `/ckb`) in the docker container.

Use `volumes` for `/opt/local/cargo/registry` and `/opt/local/cargo/git` can
cache files to make `cargo` command faster.

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
[`bionic-rustc1.34.1`]: https://github.com/yangby-cryptape/ckb-dockerfiles/tree/master/ubuntu/bionic/build
[`bionic`]: https://github.com/yangby-cryptape/ckb-dockerfiles/tree/master/ubuntu/bionic/run
