FROM ubuntu:16.04
LABEL NathanDai <daizheng@dashwood.xyz>

ADD sources.list /etc/apt/

RUN apt-get update && apt-get install -y haproxy

CMD ["service", "haproxy", "start"]