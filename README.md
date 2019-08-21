# llvm-toolchain

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/nobodyxu/llvm-toolchain)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/nobodyxu/llvm-toolchain)

Docker image contains llvm toolchains in `/opt/llvm`.

# tags available

 - tag `latest` contains the latest stable llvm toolchain (currently llvm 8) under `/opt/llvm/`.

 ![nobodyxu/llvm-toolchain:latest size](https://img.shields.io/microbadger/image-size/nobodyxu/llvm-toolchain/latest)
 - tag `dev` contains not only the llvm toolchain, but also the build tree for it in `/opt/llvm/src/llvm/build-stage2`.

 ![nobodyxu/llvm-toolchain:dev size](https://img.shields.io/microbadger/image-size/nobodyxu/llvm-toolchain/dev)

To pull the image, use `docker pull nobodyxu/llvm-toolchain:tag`.

# How to build

To build it on your only computer that is not `x86_64` architecture, you need to run

```
echo -e "FROM debian:buster\nRUN mkdir -p /opt/llvm/src" | docker build -f - --tag=nobodyxu/llvm-toolchain:stage1
```

before running `make` (a technique to save compilation time by reusing previous build).

On `x86_64` architecture, just run `make`.

## Proxy for `apt` and `git` during the build

During the build, the port `8000` and `8080` is being checked for accessibility. If these port is on, the build will assume the `apt` and `git` proxy respectively is up on your computer.

 - To specify a different port, pass environment variable `APT_PROXY_PORT` and `GIT_PROXY_PORT` respectively when invoking `make`.
 - To specify a different host, pass environment variable `APT_PROXY_HOST` and `GIT_PROXY_HOST` respectively when invoking `make`.
 - To use no proxy, pass environment variable `NO_APT_PROXY` and `NO_GIT_PROXY` respectively when invoking `make`.

# Credit

This repository use [NobodyXu/install-clang](https://github.com/NobodyXu/install-clang) which is forked from [rsmmr/install-clang](https://github.com/rsmmr/install-clang).

# Request for more features

Simply open a issue in the github repository [NobodyXu/llvm-toolchain](https://github.com/NobodyXu/llvm-toolchain) and I will respond to that as soon as possible.

# Contirbution

Any pull request regarding bug fix or new feature is welcomed!
