$LIB_DIR = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift($LIB_DIR) unless $LOAD_PATH.include?($LIB_DIR)

require 'date'
require 'forwardable'
require 'io/console'
require 'logger'
require 'optparse'
require 'set'
require 'singleton'
require 'time'

require 'vedeu/support/log'

# Vedeu is a GUI framework for terminal/console applications written in Ruby.
#
module Vedeu

  DOCS_URL = 'http://www.rubydoc.info/github/gavinlaking/vedeu/master'

  extend Forwardable
  extend self

  def_delegators Vedeu::Log, :log

  def self.focusable
    @_focusable ||= Vedeu::Focus
  end

  def self.geometries
    @_geometries ||= Vedeu::Geometries.new(Vedeu::Geometry)
  end

  def self.groups
    @_groups ||= Vedeu::Groups.new(Vedeu::Group)
  end

  def self.interfaces
    @_interfaces ||= Vedeu::Interfaces.new(Vedeu::Interface)
  end

  def self.menus
    @_menus ||= Vedeu::Menus.new(Vedeu::Menu)
  end

  # When Vedeu is included within one of your classes, you should have all
  # API methods at your disposal.
  #
  # @example
  #   class YourClassHere
  #     include Vedeu
  #     ...
  #
  def included(receiver)
    receiver.send(:include, API)
    receiver.extend(API)
  end

  private

end # Vedeu

require 'vedeu/all'

require 'vedeu/support/trace'
Vedeu::Trace.call
# force tracing
# Vedeu::Trace.call({ trace: true })
