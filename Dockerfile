FROM ubuntu:16.04

MAINTAINER mircea.milencianu <mircea.milencianu@endava.com>

RUN apt-get update \
    && apt-get install -y sudo \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:webupd8team/java -y \
    && apt-get update \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-installer \
    && apt-get clean


RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y net-tools file git curl zip libncurses5:i386 libstdc++6:i386 zlib1g:i386 \ 
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists /var/cache/apt

# Set up environment variables
ENV ANDROID_HOME="/home/emuUser/sdk-tools" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip"

RUN useradd -m emuUser \
    && echo "emuUser:emulator" | chpasswd && adduser emuUser sudo

USER emuUser

WORKDIR /home/emuUser
	
# Install android sdk
RUN mkdir sdk-tools \
    && cd sdk-tools \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip 

WORKDIR /home/emuUser/sdk-tools/tools/bin

RUN echo yes | ./sdkmanager --licenses

ENV PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}"
