# fork of https://github.com/blang/latex-docker / Benedikt Lang <mail@blang.io> 
FROM debian:jessie
MAINTAINER Warren MacEvoy <wmacevoy@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q \
    && apt-get install -qy build-essential wget libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# Install TexLive with scheme-basic
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
	mkdir /install-tl-unx; \
	tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1; \
    echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile; \
	/install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile; \
    rm -r /install-tl-unx; \
	rm install-tl-unx.tar.gz

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linux:${PATH}"

WORKDIR /data
ENV HOME /home
# Install latex packages
RUN tlmgr install latexmk

VOLUME ["/data","/home"]

# needed for basic build rules
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get install -y apt-file
RUN apt-file update
RUN apt-get install -y software-properties-common

# needed for asymptote to run
RUN apt-get install -y freeglut3 ghostscript libglu1 libosmesa6 
