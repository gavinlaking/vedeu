# Vedeu is a GUI framework for terminal/console applications written in Ruby.
#
module Vedeu

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

end # Vedeu

$LIB_DIR = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift($LIB_DIR) unless $LOAD_PATH.include?($LIB_DIR)

require 'date'
require 'forwardable'
require 'io/console'
require 'logger'
require 'optparse'
require 'set'

require 'vedeu/support/exceptions'
require 'vedeu/support/common'
require 'vedeu/configuration/cli'
require 'vedeu/configuration/api'
require 'vedeu/configuration/configuration'

require 'vedeu/support/log'
require 'vedeu/support/trace'

require 'vedeu/models/keymap'
require 'vedeu/api/keymap'
require 'vedeu/api/api'

require 'vedeu/support/coercions'
require 'vedeu/support/colour_translator'
require 'vedeu/models/background'
require 'vedeu/models/foreground'
require 'vedeu/support/presentation'
require 'vedeu/models/composition'

require 'vedeu/support/repository'
require 'vedeu/support/position'
require 'vedeu/support/esc'
require 'vedeu/support/terminal'
require 'vedeu/support/event'

require 'vedeu/models/geometry'
require 'vedeu/models/colour'
require 'vedeu/models/style'
require 'vedeu/models/interface'
require 'vedeu/models/cursor'

require 'vedeu/models/char'
require 'vedeu/models/line'
require 'vedeu/models/stream'
require 'vedeu/models/offset'

require 'vedeu/repositories/events'

require 'vedeu/api/defined'
require 'vedeu/api/composition'
require 'vedeu/api/helpers'
require 'vedeu/api/interface'
require 'vedeu/api/line'
require 'vedeu/api/menu'
require 'vedeu/api/stream'

require 'vedeu/support/keymap_validator'
require 'vedeu/repositories/positional'
require 'vedeu/repositories/offsets'
require 'vedeu/repositories/menus'
require 'vedeu/repositories/keymaps'
require 'vedeu/repositories/interfaces'
require 'vedeu/repositories/groups'
require 'vedeu/repositories/focus'
require 'vedeu/repositories/events'
require 'vedeu/repositories/buffers'
require 'vedeu/repositories/cursors'

require 'vedeu/support/registrar'
require 'vedeu/support/refresh'

require 'vedeu/output/clear'
require 'vedeu/output/compositor'
require 'vedeu/output/render'
require 'vedeu/output/view'
require 'vedeu/output/viewport'

require 'vedeu/support/grid'
require 'vedeu/support/menu'

require 'vedeu/input/input'

require 'vedeu/application'
require 'vedeu/launcher'

# Vedeu::Trace.call({ trace: true })
