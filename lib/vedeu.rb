module Vedeu

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

require 'vedeu/models/attributes/attributes'
require 'vedeu/models/attributes/colour_translator'
require 'vedeu/models/composition'
require 'vedeu/support/terminal'
require 'vedeu/models/geometry'
require 'vedeu/models/colour'
require 'vedeu/models/interface'
require 'vedeu/models/line'
require 'vedeu/models/store'
require 'vedeu/models/stream'

require 'vedeu/api/api'
require 'vedeu/api/events'
require 'vedeu/api/grid'
require 'vedeu/api/helpers'
require 'vedeu/api/interface'
require 'vedeu/api/line'
require 'vedeu/api/log'
require 'vedeu/api/stream'

require 'vedeu/application'
require 'vedeu/configuration'
require 'vedeu/launcher'

require 'vedeu/output/buffers'
require 'vedeu/output/clear'
require 'vedeu/output/render'
require 'vedeu/output/view'

require 'vedeu/support/position'
require 'vedeu/support/esc'
require 'vedeu/support/input'
require 'vedeu/support/menu'
