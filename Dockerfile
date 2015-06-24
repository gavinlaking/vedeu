FROM ubuntu:15.04
MAINTAINER Gavin Laking <gavinlaking@gmail.com>

# Build dependencies
RUN apt-get update && apt-get install -y --force-yes \
    software-properties-common \
    build-essential \
    openssl \
    ca-certificates \
    git-core \
    autoconf \
    gawk \
    libreadline-dev \
    libyaml-dev \
    libgdbm-dev \
    libncurses5-dev \
    automake \
    libtool \
    bison \
    pkg-config \
    curl \
    wget \
    libxslt-dev \
    libxml2-dev \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    make
RUN apt-get clean -y && apt-get autoremove -y

# Chruby
RUN wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
RUN tar -xzvf chruby-0.3.9.tar.gz && cd chruby-0.3.9/ && make install

# Ruby Install
RUN wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
RUN tar -xzvf ruby-install-0.5.0.tar.gz && cd ruby-install-0.5.0/ && make install

# Install Ruby 2.2.2
RUN ruby-install ruby 2.2.2

# Setup Chruby
RUN echo '[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/chruby.sh' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/auto.sh' >> $HOME/.bashrc
RUN echo 'chruby ruby-2.2.2' >> $HOME/.bash_profile
RUN echo "---\n:benchmark: false\n:bulk_threshold: 1000\n:backtrace: false\n:verbose: true\ngem: --no-ri --no-rdoc" >> $HOME/.gemrc

# Setup PATH
ENV PATH /opt/rubies/ruby-2.2.2/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/vedeu/gem/bin

# Get ruby version
RUN ruby -v

# Create a fake home directory
RUN usr/sbin/useradd --create-home --home-dir /home/vedeu --shell /bin/bash vedeu

# Make files
RUN mkdir /home/vedeu/gem
RUN chown -R vedeu:vedeu /home/vedeu
RUN gem install bundler

# VOLUME .:/home/vedeu/gem

ADD . /home/vedeu/gem/
WORKDIR /home/vedeu
USER vedeu

# To build this file:
#
#     sudo docker build -t vedeu/my_first_app .
#
#
# Once we're up and running, we can create a shell to the docker instance and
# start running commands against it.
#
#     sudo docker run -it -v $PWD:/home/vedeu/gem:rw vedeu/my_first_app /bin/bash
#
#

