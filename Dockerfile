FROM ubuntu:18.10
LABEL maintainer="Steffen Köhler <stefen.koehler@gmail.com>"
LABEL Description="Image for building binaries for arm and ti using cmake and python3"

WORKDIR /work

ADD . /work

# Install any needed packages specified in requirements.txt
RUN apt update && \
apt upgrade -y \
apt install -y build-essential git bzip2 python3 python3-pip cmake wget && \
apt clean && \
pip3 install requests && \
wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 | tar -xj 

ENV PATH "/work/gcc-arm-none-eabi-8-2019-q3-update/bin:$PATH"
