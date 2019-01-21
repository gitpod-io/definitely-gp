FROM "gitpod/workspace-full-vnc"

ENV ANDROID_HOME=/home/gitpod/android-sdk-linux \
    FLUTTER_HOME=/home/gitpod/flutter \
    PATH=/usr/lib/dart/bin:$FLUTTER_HOME/bin:$M2_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH \
    MAVEN_VERSION=3.5.3
ENV M2_HOME=/home/gitpod/apache-maven-$MAVEN_VERSION

RUN sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' && \
    sudo apt-get -y update && \
    sudo apt-get -y install  build-essential dart libkrb5-dev gcc make && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo apt-get -y clean && \
    sudo rm -rf /var/lib/apt/lists/*

RUN cd ${HOME} && wget -qO- "https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | \
        tar -zx --strip-components=1 -C /home/gitpod/apache-maven-$MAVEN_VERSION/;

RUN cd /home/gitpod && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar -xvf android-sdk.tgz && rm android-sdk.tgz && \
    echo y | android update sdk --all --force --no-ui --filter platform-tools,build-tools-21.1.1,android-21,sys-img-armeabi-v7a-android-21 && \
    echo "no" | android create avd \
                --name che \
                --target android-21 \
                --abi armeabi-v7a && \
    for f in "${HOME}/.android" "${HOME}/android-sdk-linux"; do \
      sudo chgrp -R 0 ${f} && \
      sudo chmod -R g+rwX ${f}; \
    done;

RUN cd /home/gitpod && wget -O flutter_sdk.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.0.0-stable.tar.xz \
    && tar -xvf flutter_sdk.tar.xz && rm flutter_sdk.tar.xz;