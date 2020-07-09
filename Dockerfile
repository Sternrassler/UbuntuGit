FROM ubuntu:bionic

LABEL maintainer="Ix Sternrassler; @sternrassler@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy remove git && \
    apt -qy full-upgrade && \
    apt-get install -yq

# Compile Git 2.26.1
RUN apt-get -qy install wget make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip && \
    wget https://github.com/git/git/archive/v2.26.1.tar.gz -O git.tar.gz && \
    tar -xf git.tar.gz && \
    cd git-* && \
    make prefix=/usr/local all && \
    make prefix=/usr/local install

# Remove Source
RUN rm -R git-2.26.1 && \
    rm git.tar.gz && \
    apt-get -qy remove wget make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip && \
    apt-get -qy autoremove && \
    apt-get -qy install libcurl3-gnutls && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Test Git 2.26.1
RUN git --version
