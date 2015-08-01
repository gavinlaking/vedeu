#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

trap('INT') { exit! }

# require 'bundler/setup' # uncomment to remove the need to do `bundle exec`.
require 'vedeu'

# An example application to demonstrate 'Hello World'.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./examples/hello_world.rb
#
class HelloWorldApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    # debug!
    log '/tmp/vedeu_hello_world.log'
  end

  Vedeu.interface 'messages' do
    background '#000000'
    foreground '#00ff00'
    geometry do
      centred!
      height   5
      width    20
    end
    keymap do
      key('q') { Vedeu.exit }
    end
  end

  Vedeu.renders do
    view 'messages' do
      lines do
        line do
          centre 'Hello World!', width: 20
        end
        line
        line do
          centre "Press 'q' to exit.", width: 20
        end
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # HelloWorldApp

HelloWorldApp.start(ARGV)
