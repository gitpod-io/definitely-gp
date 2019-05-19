FROM gitpod/workspace-full
USER root
RUN apt-get update && apt-get install -y \
      build-essential \
      git \
      bzip2 \
      wget \
      toilet \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* && \
    wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 -O gcc-arm-none-eabi.tar.bz2 && \
    tar -C /opt -xjf gcc-arm-none-eabi.tar.bz2 && \
    mv /opt/gcc-arm-none-eabi* /opt/gcc-arm-none-eabi && \
    rm gcc-arm-none-eabi.tar.bz2 && \
    pip install mbed-cli
RUN echo '#!/bin/bash -e\n\
[[ ! -z $(find -name "*.lib" -type f) ]] && mbed deploy .\n\
find -name requirements.txt -type f -exec pip install -U -r {} \;' > /opt/arm-mbed-init.sh

ENV PATH "/opt/gcc-arm-none-eabi/bin:$PATH"
