# fork of https://github.com/blang/latex-docker / Benedikt Lang <mail@blang.io> 
FROM debian:stretch
MAINTAINER Warren MacEvoy <wmacevoy@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# needed for basic build rules
RUN apt-get update && apt-get install -y software-properties-common

RUN apt-get install -y texlive asymptote
RUN apt-get install -y wget xzdec gnupg latexmk
RUN tlmgr init-usertree

WORKDIR /data
ENV HOME /home

VOLUME ["/data","/home"]
