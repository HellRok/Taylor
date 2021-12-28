FROM taylor/build-linux as build_base
WORKDIR /app/export

ARG VERSION=main

RUN \
  git clone --branch 3.0.0 --depth 1 https://github.com/mruby/mruby.git /app/mruby &&\
  cd /app/mruby &&\
  rake &&\
  git clone --branch $VERSION --depth 1 https://github.com/HellRok/Taylor.git /app/taylor

COPY . /app/export
