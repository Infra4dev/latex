FROM debian:sid-slim

ENV DEBIAN_FRONTEND noninteractive

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

RUN adduser               \
    --home "$USER_HOME"   \
    --uid $USER_ID        \
    --gecos "$USER_GECOS" \
    --disabled-password   \
    "$USER_NAME"

# hadolint ignore=DL3008
RUN apt-get update -qq                                                       \
    && apt-get install --no-install-recommends -y make git wget texlive-full \
    && apt-get --purge remove -y .\*-doc$                                    \
    &&  apt-get clean -y                                                     \
    &&  rm -rf /var/lib/apt/lists/*

USER latex