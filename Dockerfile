FROM debian:bullseye
ARG TARGETPLATFORM

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git screen vim wget file man u-boot-tools device-tree-compiler build-essential cpio autoconf autogen automake sudo ncurses-dev python libtool dosfstools tclsh qemu-user fdisk

RUN true \
    && if test "$TARGETPLATFORM" = "linux/arm64"; then ARCH=aarch64; else ARCH=x86_64; fi \
    && mkdir -p /work/toolchain \
    && cd /work/toolchain \
    && wget https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-${ARCH}-arm-none-linux-gnueabihf.tar.xz \
    && tar -xf gcc-arm-*.xz \
    && rm -f *.xz \
    && ln -s gcc-arm-* toolchain \
    && ln -s toolchain/arm-none-linux-gnueabihf/libc/ sysroot-glibc

ADD sources.list /sources.list
RUN if test "$TARGETPLATFORM" = "linux/arm64"; then true \
        && dpkg --add-architecture amd64 \
        && mv -f /sources.list /etc/apt \
        && apt-get update && apt-get install -y libc-dev:amd64 \
    ;else rm /sources.list; fi

RUN true \
    && cd /work \
    && git clone https://github.com/DirtyHairy/r77-firmware-ng.git \
    && cd r77-firmware-ng \
    && git submodule update --init --recursive

ENV OUTDIR=/work/out
ENV TOOLCHAIN=/work/toolchain
ENV PATH="/work/toolchain/toolchain/bin:${PATH}"

WORKDIR /work/r77-firmware-ng
