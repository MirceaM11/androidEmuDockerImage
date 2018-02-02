# Android development environment for ubuntu.
#
###1###  first stage: pulling ubuntu:16.04
FROM ubuntu:16.04

MAINTAINER mircea.milencianu <mircea.milencianu@endava.com>

# Update packages

RUN apt-get -y update \
    && apt-get -y install software-properties-common bzip2 net-tools curl \
    && apt-get -y update

###2### second stage: pulling openjdk:8
FROM openjdk:8

# Set up environment variables
ENV ANDROID_HOME="/opt/sdk-tools/" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip"


#Steps:
# -- build image like this with the commented lines
# -- add some general/default entrypoint only to allow you to connect to the container
# -- log into container and inspect $ANDROID_HOME and see what the heck does it install there
# -- and if it installs something
# 

# Install android sdk
RUN mkdir "$ANDROID_HOME" .android \
    && cd "$ANDOID_HOME" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip

# Add android tools and platform tools to PATH
#RUN cd /opt/sdk-tools/tools/bin  && \
#RUN  /opt/sdk-tools/tools/bin/sdkmanager --licenses 
#&& \
#    ./sdkmanager "platform-tools" "platforms;android-27" "build-tools;27.0.2" "system-images;android-27;google_apis_playstore;x86"

# Create fake keymaps
#RUN mkdir /usr/local/android-sdk/tools/keymaps && \
#    touch /usr/local/android-sdk/tools/keymaps/en-us

# Add entrypoint
#ADD entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]
