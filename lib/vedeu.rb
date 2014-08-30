module Vedeu

  EntityNotFound      = Class.new(StandardError)
  GroupNotFound       = Class.new(StandardError)
  InterfaceNotFound   = Class.new(StandardError)
  InvalidSyntax       = Class.new(StandardError)
  ModeSwitch          = Class.new(StandardError)
  NoInterfacesDefined = Class.new(StandardError)
  NotImplemented      = Class.new(StandardError)
  OutOfRange          = Class.new(StandardError)

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
require 'vedeu/support/events'

require 'vedeu/models/geometry'
require 'vedeu/models/colour'
require 'vedeu/models/style'
require 'vedeu/models/interface'
require 'vedeu/models/line'
require 'vedeu/models/stream'

require 'vedeu/api/api'
require 'vedeu/api/composition'
require 'vedeu/api/helpers'
require 'vedeu/api/interface'
require 'vedeu/api/line'
require 'vedeu/api/stream'

require 'vedeu/support/input'

require 'vedeu/application'
require 'vedeu/launcher'

require 'vedeu/support/focus'
require 'vedeu/support/groups'
require 'vedeu/support/buffers'
require 'vedeu/support/clear'
require 'vedeu/support/render'
require 'vedeu/support/view'
require 'vedeu/support/buffer'
require 'vedeu/support/grid'
require 'vedeu/support/menu'
require 'vedeu/support/cursor'

