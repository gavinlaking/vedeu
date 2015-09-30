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

# Vedeu is a GUI framework for terminal/console applications written
# in Ruby.
#
module Vedeu

  extend Forwardable
  extend self

  # Return the name of currently focussed interface.
  #
  # @return [Vedeu::Models::Focus]
  def self.focusable
    @focusable ||= Vedeu::Models::Focus
  end

end # Vedeu

require 'vedeu/all'
