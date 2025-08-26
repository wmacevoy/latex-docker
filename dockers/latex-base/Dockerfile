# fork of https://github.com/blang/latex-docker / Benedikt Lang <mail@blang.io>
FROM debian:bookworm
MAINTAINER Warren MacEvoy <wmacevoy@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive

# base tools and full TeX Live stack (includes pdflatex/bibtex/etc.)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      make \
      perl \
      texlive-full \
      asymptote \
      latexmk \
      xindy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data
ENV HOME=/home

VOLUME ["/data","/home"]
