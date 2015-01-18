# $LIB_DIR = File.dirname(__FILE__) + '/../lib'
# $LOAD_PATH.unshift($LIB_DIR) unless $LOAD_PATH.include?($LIB_DIR)

# Vedeu::Trace.call({ trace: true })

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

  def self.buffers_repository
    @_buffers_repository ||= Vedeu::Buffers.new(Vedeu::Buffer)
  end

  def self.cursors_repository
    @_cursors_repository ||= Vedeu::Cursors.new(Vedeu::Cursor)
  end

  def self.focus_repository
    @_focus_repository ||= Vedeu::Focus
  end

  def self.events_repository
    @_events_repository ||= Vedeu::Events.new(Vedeu::Model::Collection)
  end

  def self.geometries_repository
    @_geometries_repository ||= Vedeu::Geometries.new(Vedeu::Geometry)
  end

  def self.groups_repository
    @_groups_repository ||= Vedeu::Groups.new(Vedeu::Group)
  end

  def self.interfaces_repository
    @_interfaces_repository ||= Vedeu::Interfaces.new(Vedeu::Interface)
  end

  def self.menus_repository
    @_menus_repository ||= Vedeu::Menus.new(Vedeu::Menu)
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

