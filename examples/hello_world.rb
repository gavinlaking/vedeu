#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

trap('INT') { exit! }

# require 'bundler/setup' # uncomment to remove the need to do `bundle exec`.
require 'vedeu'

# An example application to demonstrate 'Hello World'.
#
class HelloWorldApp

  include Vedeu

  configure do
    debug!
    log '/tmp/vedeu_hello_world.log'
  end

  bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'messages' do
    background '#000000'
    foreground '#00ff00'
    geometry do
      centred!
      height   3
      width    20
    end
  end

  renders do
    view 'messages' do
      lines do
        centre 'Hello World!', width: 20
        line
        centre "Press 'q' to exit.", width: 20
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end

HelloWorldApp.start(ARGV)
