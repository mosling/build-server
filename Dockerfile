# see https://wiki.ubuntu.com/Releases
FROM ubuntu:18.04

LABEL maintainer="Steffen Köhler <stefen.koehler@gmail.com>"
LABEL Description="Image for building projects for arm using cmake, python3 and asciidoc"

WORKDIR /work
ADD . /work

RUN set -xe \
    \
# update/upgrade packages and install additional packages
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y build-essential git bzip2 python3 python3-pip wget \
    \
# install to current cmake see https://blog.kitware.com/cmake-python-wheels/
    && pip3 install cmake \
    \
# install ruby/java runtime and asciidoctor with pdf and diagrams
    && apt-get install -y ruby \
    && apt-get install -y default-jre \
    && apt-get install -y graphviz \
    && gem install asciidoctor-pdf \
    && gem install rouge coderay asciidoctor-diagram\
    \
# install additional python3 modules
    && pip3 install requests \
    \
# get the linux binary and unzip it into /work 
    && wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj \
    \
# starting cleanup
    && apt-get -y autoremove \
    && apt-get clean

ENV PATH "/work/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"
