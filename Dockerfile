FROM debian:stretch-slim
MAINTAINER shyouhei@ruby-lang.org

ENV DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386
RUN echo 'deb-src http://deb.debian.org/debian stretch main' > /etc/apt/sources.list.d/deb-src.list
RUN echo $'Dpkg::Use-Pty "0";\nquiet "2";\nAPT::Install-Recommends "0";' > /etc/apt/apt.conf.d/99autopilot
RUN apt-get update
RUN apt-get install build-essential
RUN apt-get install gcc-multilib
RUN apt-get install bison
RUN apt-get install libruby2.3:amd64
RUN apt-get install libruby2.3:i386
RUN apt-get build-dep ruby2.3
RUN apt-get upgrade    \
 && apt-get autoremove \
 && apt-get clean

ADD Rakefile all-ruby versions.json /all-ruby/
ADD patch /all-ruby/patch/
WORKDIR /all-ruby

RUN rake all-0     && rm -rf DIST    0.*/ruby* && rake dedup
RUN rake all-1.0   && rm -rf DIST   1.0*/ruby* && rake dedup
RUN rake all-1.1a  && rm -rf DIST   1.1*/ruby* && rake dedup
RUN rake all-1.1b  && rm -rf DIST   1.1*/ruby* && rake dedup
RUN rake all-1.1c  && rm -rf DIST   1.1*/ruby* && rake dedup
RUN rake all-1.1d  && rm -rf DIST   1.1*/ruby* && rake dedup
RUN rake all-1.2   && rm -rf DIST   1.2*/ruby* && rake dedup
RUN rake all-1.3   && rm -rf DIST   1.3*/ruby* && rake dedup
RUN rake all-1.4   && rm -rf DIST   1.4*/ruby* && rake dedup
RUN rake all-1.6   && rm -rf DIST   1.6*/ruby* && rake dedup
RUN rake all-1.8   && rm -rf DIST   1.8*/ruby* && rake dedup
RUN rake all-1.8.5 && rm -rf DIST 1.8.5*/ruby* && rake dedup
RUN rake all-1.8.6 && rm -rf DIST 1.8.6*/ruby* && rake dedup
RUN rake all-1.8.7 && rm -rf DIST 1.8.7*/ruby* && rake dedup
RUN rake all-1.9.0 && rm -rf DIST 1.9.0*/ruby* && rake dedup
RUN rake all-1.9.1 && rm -rf DIST 1.9.1*/ruby* && rake dedup
RUN rake all-1.9.2 && rm -rf DIST 1.9.2*/ruby* && rake dedup
RUN rake all-2.0.0 && rm -rf DIST 2.0.0*/ruby* && rake dedup
RUN rake all-2.1   && rm -rf DIST   2.1*/ruby* && rake dedup
RUN rake all-2.2   && rm -rf DIST   2.2*/ruby* && rake dedup
RUN rake all-2.3   && rm -rf DIST   2.3*/ruby* && rake dedup
RUN rake all-2.4   && rm -rf DIST   2.4*/ruby* && rake dedup
RUN rake all-2.5.0 && rm -rf DIST 2.5.0*/ruby* && rake dedup

