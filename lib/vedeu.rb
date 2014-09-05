#
#
# Vedeu is a GUI framework for terminal/console applications written in Ruby.
#
#
module Vedeu

  # Raised when Vedeu attempts to access a named buffer that does not exist.
  BufferNotFound = Class.new(StandardError)

  # Raised when trying to access a group of interfaces which do not exist by
  # this name.
  GroupNotFound = Class.new(StandardError)

  # Raised when an interface cannot be found by name.
  InterfaceNotFound = Class.new(StandardError)

  # Raised when Vedeu attempts to parse a {Vedeu.view} or {Vedeu.interface} and
  # encounters a problem.
  InvalidSyntax = Class.new(StandardError)

  # Raised intentionally when the client application wishes to switch between
  # cooked and raw (or vice versa) terminal modes. Vedeu is hard-wired to use
  # the `Escape` key to trigger this change for the time being.
  ModeSwitch = Class.new(StandardError)

  # Raised when attempting to reach the currently in focus interface, when no
  # interfaces have been defined yet.
  NoInterfacesDefined = Class.new(StandardError)

  # Raised to remind me (or client application developers) that the subclass
  # implements the functionality sought.
  NotImplemented = Class.new(StandardError)

  # Raised when trying to access an interface column less than 1 or greater
  # than 12. Vedeu is hard-wired to a 12-column layout for the time being.
  OutOfRange = Class.new(StandardError)

  # When Vedeu is included within one of your classes, you should have all
  # API methods at your disposal.
  #
  # @example
  #   class YourClassHere
  #     include Vedeu
  #     ...
  #
  def self.included(receiver)
    receiver.send(:include, API)
    receiver.extend(API)
  end

end

require 'date'
require 'forwardable'
require 'io/console'
require 'logger'
require 'optparse'
require 'set'

require 'vedeu/support/common'
require 'vedeu/support/log'
require 'vedeu/support/trace'
require 'vedeu/configuration'

require 'vedeu/models/attributes/coercions'
require 'vedeu/models/attributes/colour_translator'
require 'vedeu/models/attributes/background'
require 'vedeu/models/attributes/foreground'
require 'vedeu/models/attributes/presentation'
require 'vedeu/models/composition'

require 'vedeu/support/position'
require 'vedeu/support/esc'
require 'vedeu/support/terminal'
require 'vedeu/support/event'

require 'vedeu/models/geometry'
require 'vedeu/models/colour'
require 'vedeu/models/style'
require 'vedeu/models/interface'
require 'vedeu/models/line'
require 'vedeu/models/stream'

require 'vedeu/repositories/events'

require 'vedeu/api/defined'
require 'vedeu/api/api'
require 'vedeu/api/composition'
require 'vedeu/api/helpers'
require 'vedeu/api/interface'
require 'vedeu/api/line'
require 'vedeu/api/stream'

require 'vedeu/repositories/interfaces'
require 'vedeu/repositories/groups'
require 'vedeu/repositories/focus'
require 'vedeu/repositories/events'
require 'vedeu/repositories/buffers'

require 'vedeu/support/compositor'
require 'vedeu/support/refresh'
require 'vedeu/support/clear'
require 'vedeu/support/render'
require 'vedeu/support/view'
require 'vedeu/support/buffer'
require 'vedeu/support/grid'
require 'vedeu/support/menu'
require 'vedeu/support/cursor'
require 'vedeu/support/input'

require 'vedeu/application'
require 'vedeu/launcher'
