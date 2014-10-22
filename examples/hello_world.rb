#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

trap('INT') { exit! }

# require 'bundler/setup' # uncomment to remove the need to do `bundle exec`.
require 'vedeu'

class HelloWorldApp
  include Vedeu

  event(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'messages' do
    background '#000000'
    centred!
    foreground '#00ff00'
    height     3
    width      20
  end

  render do
    view 'messages' do
      line '    Hello World!'
      line
      line " Press 'q' to exit. "
    end
  end

  def self.start
    Vedeu::Launcher.execute!(ARGV)
  end
end

HelloWorldApp.start
