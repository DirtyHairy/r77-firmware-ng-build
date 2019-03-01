FROM debian:stretch

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git screen vim wget file man u-boot-tools device-tree-compiler build-essential cpio autoconf autogen automake sudo ncurses-dev python libtool qemu-user

RUN true \
    && mkdir -p /work/toolchain \
    && cd /work/toolchain \
    && wget http://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/arm-linux-gnueabihf/gcc-linaro-7.4.1-2019.02-x86_64_arm-linux-gnueabihf.tar.xz \
    && wget http://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/arm-linux-gnueabihf/sysroot-glibc-linaro-2.25-2019.02-arm-linux-gnueabihf.tar.xz \
    && tar -xf gcc-linaro-*.xz \
    && tar -xf sysroot-glibc-linaro-*.xz \
    && rm -f *.xz \
    && ln -s gcc-linaro-* toolchain \
    && ln -s sysroot-glibc-linaro-* sysroot-glibc

RUN true \
    && cd /work \
    && git clone https://github.com/DirtyHairy/r77-firmware-ng.git \
    && cd r77-firmware-ng \
    && git submodule update --init --recursive

ENV OUTDIR=/work/out
ENV TOOLCHAIN=/work/toolchain
ENV PATH="/work/toolchain/toolchain/bin:${PATH}"

WORKDIR /work/r77-firmware-ng
