FROM ubuntu:15.04
MAINTAINER Gavin Laking <gavinlaking@gmail.com>

# Build dependencies
RUN apt-get update && apt-get install -y --force-yes \
    autoconf \
    automake \
    bison \
    build-essential \
    ca-certificates \
    curl \
    gawk \
    git-core \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libreadline-dev \
    libssl-dev \
    libtool \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    make \
    openssl \
    pkg-config \
    software-properties-common \
    vim \
    wget \
    zlib1g-dev

RUN apt-get clean -y && apt-get autoremove -y

# Create a fake home directory
RUN usr/sbin/useradd --create-home --home-dir /home/vedeu --shell /bin/bash vedeu
RUN mkdir /home/vedeu/gem
RUN chown -R vedeu:vedeu /home/vedeu

# Chruby
RUN wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
RUN tar -xzvf chruby-0.3.9.tar.gz && cd chruby-0.3.9/ && make install

# Ruby Install
RUN wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
RUN tar -xzvf ruby-install-0.5.0.tar.gz && cd ruby-install-0.5.0/ && make install

# Install Ruby 2.3.1
RUN ruby-install ruby 2.3.1
RUN chown -R vedeu:vedeu /opt/rubies

# Setup Chruby
RUN echo '[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/chruby.sh' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/auto.sh' >> $HOME/.bashrc
RUN echo 'chruby ruby-2.3.1' >> $HOME/.bash_profile
RUN echo "---\n:benchmark: false\n:bulk_threshold: 1000\n:backtrace: false\n:verbose: true\ngem: --no-ri --no-rdoc" >> $HOME/.gemrc

# Setup PATH
ENV PATH /opt/rubies/ruby-2.3.1/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/vedeu/gem/bin

RUN gem install bundler

ADD . /home/vedeu/gem/
WORKDIR /home/vedeu/gem
RUN chown -R vedeu:vedeu .
USER vedeu
RUN bundle install --deployment
WORKDIR /home/vedeu

# To build this file:
#
#     sudo docker build -t vedeu/my_first_app .
#
#
# Once we're up and running, we can create a shell to the docker instance and
# start running commands against it.
#
#     sudo docker run -it -v $PWD:/home/vedeu/gem:rw -v ~/Docker/:/home/vedeu/docker:rw vedeu/my_first_app /bin/bash
#
#
