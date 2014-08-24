module Vedeu

  EntityNotFound = Class.new(StandardError)
  InvalidHeight  = Class.new(StandardError)
  InvalidWidth   = Class.new(StandardError)
  ModeSwitch     = Class.new(StandardError)
  NotImplemented = Class.new(StandardError)
  OutOfRange     = Class.new(StandardError)
  RefreshFailed  = Class.new(StandardError)
  XOutOfBounds   = Class.new(StandardError)
  YOutOfBounds   = Class.new(StandardError)

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

require 'vedeu/configuration'

require 'vedeu/models/attributes/attributes'
require 'vedeu/models/attributes/colour_translator'
require 'vedeu/models/attributes/background'
require 'vedeu/models/attributes/foreground'
require 'vedeu/models/composition'
require 'vedeu/support/terminal'
require 'vedeu/models/geometry'
require 'vedeu/models/colour'
require 'vedeu/models/interface'
require 'vedeu/models/line'
require 'vedeu/models/store'
require 'vedeu/models/stream'

require 'vedeu/api/api'
require 'vedeu/api/composition'
require 'vedeu/api/helpers'
require 'vedeu/api/interface'
require 'vedeu/api/line'
require 'vedeu/api/stream'

require 'vedeu/application'
require 'vedeu/launcher'

require 'vedeu/output/buffers'
require 'vedeu/output/clear'
require 'vedeu/output/render'
require 'vedeu/output/view'

require 'vedeu/support/buffer'
require 'vedeu/support/position'
require 'vedeu/support/esc'
require 'vedeu/support/event'
require 'vedeu/support/events'
require 'vedeu/support/grid'
require 'vedeu/support/input'
require 'vedeu/support/log'
require 'vedeu/support/menu'
require 'vedeu/support/trace'
