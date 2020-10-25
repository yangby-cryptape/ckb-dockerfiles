# [Unofficial] CKB Dockerfiles

Dockerfiles for [CKB].

## Dockers

All docker images can be found in [my page][my-docker-hub-url] at Docker Hub
Registry.

### CKB-Build

Build environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`debian-buster-rust1.46.0`]
  - [`ubuntu-focal-rust1.46.0`]

Start the docker as follows:

```bash
docker run --rm -it \
    --workdir "${DOCKER_DIR}" \
    --volume "${HOST_DIR}:${DOCKER_DIR}" \
    --volume "rust-registry:/opt/local/cargo/registry" \
    --volume "rust-git:/opt/local/cargo/git" \
    yangby0cryptape/ckb-build:latest \
    ${COMMANDS}
```

Put the source codes of [CKB] in `${HOST_DIR}` in the host filesystem and mount
it as `workdir` (default is `/ckb`) in the docker container.

Use `volumes` for `/opt/local/cargo/registry` and `/opt/local/cargo/git` can
cache files to make `cargo` command faster.

### CKB-Run

Runtime environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`debian-buster`]
  - [`ubuntu-focal`]

Start the docker as follows:

```bash
docker run --rm -it \
    --workdir "${DOCKER_DIR}" \
    --volume "${HOST_DIR}:${DOCKER_DIR}" \
    yangby0cryptape/ckb-run:latest \
    ${COMMANDS}
```

Put the executable file of [CKB] in `${HOST_DIR}` in the host filesystem and
mount it as `workdir` (default is `/ckb`) in the docker container.

[CKB]: https://github.com/nervosnetwork/ckb
[my-docker-hub-url]: https://hub.docker.com/u/yangby0cryptape/
[`debian-buster-rust1.46.0`]: debian/buster/build
[`debian-buster`]: debian/buster/run
[`ubuntu-focal-rust1.46.0`]: ubuntu/focal/build
[`ubuntu-focal`]: ubuntu/focal/run
