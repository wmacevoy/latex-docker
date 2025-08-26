# fork of https://github.com/blang/latex-docker / Benedikt Lang <mail@blang.io>
ARG DEBIAN_SUITE=bookworm
FROM debian:${DEBIAN_SUITE}
MAINTAINER Warren MacEvoy <wmacevoy@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive
ARG TL_PACKAGES="texlive-full asymptote latexmk xindy"

# base tools and full TeX Live stack (includes pdflatex/bibtex/etc.)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      make \
      perl \
      ${TL_PACKAGES} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data
ENV HOME=/home

VOLUME ["/data","/home"]
