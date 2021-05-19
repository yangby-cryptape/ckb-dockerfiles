# [Unofficial] CKB Dockerfiles

Dockerfiles for [CKB].

## Dockers

All docker images can be found in [my page][my-docker-hub-url] at Docker Hub
Registry.

### [CKB]

#### CKB-Build

Build environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`debian-buster-rust1.51.0`]
  - [`ubuntu-focal-rust1.51.0`]

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

#### CKB-Dev

Development environment for [CKB].

Supported tags and respective `Dockerfile` links:
  - [`debian-buster-rust1.51.0-riscv20191209`]

Start the docker as follows:

```bash
docker run --rm -it \
    --workdir "${DOCKER_DIR}" \
    --volume "${HOST_DIR}:${DOCKER_DIR}" \
    --volume "rust-registry:/opt/local/cargo/registry" \
    --volume "rust-git:/opt/local/cargo/git" \
    yangby0cryptape/ckb-dev:latest \
    ${COMMANDS}
```

This docker is an enhanced version of `yangby0cryptape/ckb-build:${TAG}`.
It includes a [RISC-V development environment].

#### CKB-Run

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

### [RISC-V]

Dockerfiles for [RISC-V] - The Free and Open RISC Instruction Set Architecture.

**Notice: [CKB] uses [a forked version of RISC-V GNU Compiler Toolchain](https://github.com/nervosnetwork/ckb-riscv-gnu-toolchain).**

#### RISCV-GNU-Toolchain

[RISC-V GNU Compiler Toolchain] is the [RISC-V] C and C++ cross-compiler.

Supported tags and respective `Dockerfile` links:
  - [`debian-buster-riscv-gnu-toolchain-20191209`]

Start the docker as follows:

```bash
docker run --rm -it \
    yangby0cryptape/ckb-riscv:debian-buster-riscv-gnu-toolchain \
    /bin/bash
```

#### RISCV-Tools

[RISC-V Tools] is a set of [RISC-V] simulators and other tools
(include [RISC-V GNU Compiler Toolchain]).

Supported tags and respective `Dockerfile` links:
  - [`debian-buster-riscv-tools-20191209`]

Start the docker as follows:

```bash
docker run --rm -it \
    yangby0cryptape/ckb-riscv:debian-buster-riscv-tools \
    /bin/bash
```

##### Testing

Start the `riscv-tools` docker:

```bash
docker run --rm -it \
    yangby0cryptape/ckb-riscv:debian-buster-riscv-tools \
    /bin/bash
```

Create a demo program:

```bash
echo -e 'int main(void) { return 42; }' > demo.c
```

Then, build it with `riscv64-unknown-elf-gcc`.

```bash
riscv64-unknown-elf-gcc -o demo demo.c
```

Run it by the [RISC-V] architectural simulator:

```bash
spike pk demo
echo $?
```
Last, enjoy it!

[CKB]: https://github.com/nervosnetwork/ckb
[RISC-V]: https://riscv.org/
[RISC-V GNU Compiler Toolchain]: https://github.com/riscv/riscv-gnu-toolchain
[RISC-V Tools]: https://github.com/riscv/riscv-tools
[my-docker-hub-url]: https://hub.docker.com/u/yangby0cryptape/
[`debian-buster-rust1.51.0-riscv20191209`]: debian/buster/dev
[`debian-buster-rust1.51.0`]: debian/buster/build
[`debian-buster`]: debian/buster/run
[`debian-buster-riscv-gnu-toolchain-20191209`]: debian/buster/riscv-gnu-toolchain
[`debian-buster-riscv-tools-20191209`]: debian/buster/riscv-tools
[`ubuntu-focal-rust1.51.0`]: ubuntu/focal/build
[`ubuntu-focal`]: ubuntu/focal/run
