# see https://wiki.ubuntu.com/Releases
FROM ubuntu:18.04

LABEL maintainer="Steffen Köhler <stefen.koehler@gmail.com>"
LABEL Description="Image for building binaries for arm and ti using cmake and python3"

WORKDIR /work
ADD . /work

RUN set -xe \
    \
# update/upgrade packages and install additional packages
    && apt update \
    && apt upgrade -y \
    && apt install -y build-essential git bzip2 python3 python3-pip wget \
    && apt clean \
    \
# install current cmake
    && wget https://github.com/Kitware/CMake/releases/download/v3.16.3/cmake-3.16.3.tar.gz \
    && tar -zxvf cmake-3.16.3.tar.gz \
    && cd cmake-3.16.3 \
    && ./bootstrap \
    && make install \
    && cd .. \
    \
# install additional python3 modules
    && pip3 install requests \
    \
# get the linux binary and unzip it into /work 
    && wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj 

ENV PATH "/work/gcc-arm-none-eabi-8-2019-q3-update/bin:$PATH"
