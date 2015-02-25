#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

# This example application shows how configuration works.
#
# First, we use the configuration API to switch debugging on, and set the
# logging to go to a file in the /tmp directory.
#
# By passing the arguments: --log /path/to/log_file.log when executing this
# example, we can demonstrate that the client application configuration is
# overridden by command line arguments.
#
# Use 'space' to refresh, 'q' to exit.
class VedeuConfigurationApp
  include Vedeu

  configure do
    colour_mode 16777216
    debug!
    log '/tmp/vedeu_configuration_app.log'
  end

  interface 'config' do
    geometry do
      width  40
      height 2
      centred!
    end
  end

  renders do
    view 'config' do
      lines do
        line Configuration.log.inspect + " " + Process.pid.to_s
      end
    end
  end

  keymap('config') do
    key(' ') { Vedeu.trigger(:_refresh_, 'config') }
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end
end

VedeuConfigurationApp.start(ARGV)
