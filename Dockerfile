FROM ubuntu:12.04

MAINTAINER Ligboy Liu "ligboy@gmail.com"

USER root
ENV USER root

RUN apt-get update -qq
# Base Dependencies
RUN apt-get install -y wget python

# JDK
RUN apt-get install -y openjdk-7-jdk

# Building Required Packages
RUN apt-get build-dep -y build-essential
RUN apt-get install -y git gnupg flex bison gperf build-essential \
                         zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
                         libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
                         libgl1-mesa-dev g++-multilib mingw32 tofrodos \
                         python-markdown libxml2-utils xsltproc zlib1g-dev:i386

RUN ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

# Configuring USB Access
#RUN wget -S -O - http://source.android.com/source/51-android.rules | sed "s/<username>/$USER/" | tee >/dev/null /etc/udev/rules.d/51-android.rules; udevadm control --reload-rules

# Install repo tool
RUN mkdir /opt/tools
ENV PATH /opt/tools:$PATH
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /opt/tools/repo
RUN chmod a+x /opt/tools/repo

# Cleaning
RUN apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Go to workspace
RUN mkdir -p /var/workspace
WORKDIR /var/workspace