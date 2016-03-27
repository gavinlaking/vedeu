#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

# An example application to demonstrate 'Hello World'.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./test/support/examples/hello_world.rb
#
class HelloWorldApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with profiling enabled will affect
  # performance.
  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu_hello_world.log'
    # profile!
  end

  Vedeu.interface 'messages' do
    background '#000000'
    foreground '#00ff00'
    geometry do
      align vertical: :middle, horizontal: :centre, width: 20, height: 5
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
