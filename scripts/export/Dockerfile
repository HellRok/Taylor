FROM appplant/mruby-cli as build_base

WORKDIR /app/mruby
RUN git clone --branch 3.0.0 --depth 1 https://github.com/mruby/mruby.git . &&\
  rake

WORKDIR /app/taylor
RUN git clone --branch main --depth 1 https://github.com/HellRok/Taylor.git .

WORKDIR /app/export

RUN \
  apt-get update -y && \
  apt-get install -y g++

COPY . /app/export

RUN chmod o+w \
    /app/export \
    /app/taylor \
    /app/taylor/include

CMD ["./entrypoint.sh"]
