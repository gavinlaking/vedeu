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
    debug!
    log '/tmp/vedeu_configuration_app.log'
  end

  interface 'config' do
    width 40
    height 2
    centred!
  end

  render do
    view 'config' do
      line Configuration.log.inspect + " " + Process.pid.to_s
    end
  end

  keys('config') do
    key(' ') { Vedeu.trigger(:_refresh_config_) }
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.new(argv).execute!
  end
end

VedeuConfigurationApp.start(ARGV)
