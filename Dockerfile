# see https://wiki.ubuntu.com/Releases
FROM ubuntu:18.04

LABEL maintainer="Steffen Köhler <stefen.koehler@gmail.com>"
LABEL Description="Image for building binaries for arm and ti using cmake and python3"

ENV CMAKE_VERSION "3.16.3"

WORKDIR /work
ADD . /work

RUN set -xe \
    \
# update/upgrade packages and install additional packages
    && apt update \
    && apt upgrade -y \
    && apt install -y build-essential git bzip2 python3 python3-pip wget \
    \
# install current cmake
    && apt install -y libssl-dev \
    && wget https://github.com/Kitware/CMake/releases/download/v3.16.3/cmake-${CMAKE_VERSION}.tar.gz \
    && tar -zxf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./bootstrap \
    && make install \
    && cd .. \
    \
# install additional python3 modules
    && pip3 install requests \
    \
# get the linux binary and unzip it into /work 
    && wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj \
    \
# starting cleanup
    && apt -y autoremove \
    && apt clean \
    && rm -rf cmake-${CMAKE_VERSION} \
    && rm -f cmake-${CMAKE_VERSION}.tar.gz

ENV PATH "/work/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"
