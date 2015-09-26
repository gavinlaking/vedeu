$LIB_DIR = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift($LIB_DIR) unless $LOAD_PATH.include?($LIB_DIR)

require 'bundler/setup'

require 'base64'
require 'date'
require 'drb'
require 'erb'
require 'fileutils'
require 'forwardable'
require 'io/console'
require 'json'
require 'logger'
require 'set'
require 'singleton'
require 'thread'
require 'time'
require 'zlib'

require 'thor'

require 'vedeu/logging/log'

# Vedeu is a GUI framework for terminal/console applications written
# in Ruby.
#
module Vedeu

  extend Forwardable
  extend self

  def_delegators Vedeu::Logging::Log, :log

  # Return the name of currently focussed interface.
  #
  # @return [Vedeu::Models::Focus]
  def self.focusable
    @focusable ||= Vedeu::Models::Focus
  end

  # :nocov:
  # When Vedeu is included within one of your classes, you should have
  # all API methods at your disposal.
  #
  # @example
  #   class YourClassHere
  #     include Vedeu
  #
  #     # ...
  #   end
  #
  # @param receiver [void]
  # @return [void]
  def included(receiver)
    receiver.send(:include, Vedeu::API::External)
    receiver.extend(Vedeu::API::External)
  end
  # :nocov:

end # Vedeu

require 'vedeu/all'
