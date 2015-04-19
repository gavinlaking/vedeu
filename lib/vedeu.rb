$LIB_DIR = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift($LIB_DIR) unless $LOAD_PATH.include?($LIB_DIR)

require 'date'
require 'drb'
require 'forwardable'
require 'io/console'
require 'json'
require 'logger'
require 'optparse'
require 'set'
require 'singleton'
require 'thread'
require 'time'

require 'vedeu/support/log'

# Vedeu is a GUI framework for terminal/console applications written in Ruby.
module Vedeu

  extend Forwardable
  extend self

  def_delegators Vedeu::Log, :log

  # @return [Vedeu::Focus]
  def self.focusable
    @focusable ||= Vedeu::Focus
  end

  # When Vedeu is included within one of your classes, you should have all
  # API methods at your disposal.
  #
  # @example
  #   class YourClassHere
  #     include Vedeu
  #     ...
  #
  # @param receiver []
  # @return [void]
  def included(receiver)
    receiver.send(:include, API)
    receiver.extend(API)
  end

  # ModelNotFound: Raised with Vedeu attempts to access a named model that does
  #   not exist.
  #
  # InvalidSyntax: Raised when Vedeu attempts to parse a {Vedeu.view} or
  #   {Vedeu.interface} and encounters a problem.
  #
  # MissingRequired: Raised when a name is not provided for a model when
  #   attempting to store it in a repository.
  #
  # ModeSwitch: Raised intentionally when the client application wishes to
  #   switch between cooked and raw (or vice versa) terminal modes. Vedeu is
  #   hard-wired to use the `Escape` key to trigger this change for the time
  #   being.
  #
  # NotImplemented: Raised to remind me (or client application developers) that
  #   the subclass implements the functionality sought.
  #
  # OutOfRange: Raised when trying to access an interface column less than 1 or
  #   greater than 12. Vedeu is hard-wired to a 12-column layout for the time
  #   being.
  #
  # VedeuInterrupt: Raised when Vedeu wishes to exit.
  #
  Exceptions = %w(
    ModelNotFound
    InvalidSyntax
    MissingRequired
    ModeSwitch
    NotImplemented
    OutOfRange
    VedeuInterrupt
  )
  Exceptions.each { |e| const_set(e, Class.new(StandardError)) }

  private

end # Vedeu

require 'vedeu/all'

require 'vedeu/support/trace'
Vedeu::Trace.call
# force tracing
# Vedeu::Trace.call({ trace: true })
