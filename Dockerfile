FROM stackbrew/ubuntu:trusty
MAINTAINER Gavin Laking <gavinlaking@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update;\
    sudo apt-get install -y --force-yes \
                         software-properties-common \
                         build-essential \
                         openssl \
                         ca-certificates \
                         git-core \
                         autoconf \
                         gawk \
                         libreadline6-dev \
                         libyaml-dev \
                         libgdbm-dev \
                         libncurses5-dev \
                         automake \
                         libtool \
                         bison \
                         pkg-config \
                         curl \
                         libxslt-dev \
                         libxml2-dev \
                         make; \
    sudo apt-get clean -y; \
    sudo apt-get autoremove -y;

RUN sudo add-apt-repository "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu  $(lsb_release -sc) main";\
    sudo apt-get update; \
    sudo apt-get install ruby2.1 ruby2.1-dev -y --force-yes; \
    sudo apt-get clean -y; \
    sudo apt-get autoremove -y;

RUN echo "---\n:benchmark: false\n:bulk_threshold: 1000\n:backtrace: false\n:verbose: true\ngem: --no-ri --no-rdoc" > ~/.gemrc; \
    /bin/bash -l -c "gem install bundler" ;

RUN git clone https://github.com/gavinlaking/vedeu.git
RUN cd vedeu; bundle install; rake
