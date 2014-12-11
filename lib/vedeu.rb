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

  # Write a message to the Vedeu log file.
  #
  # @param message [String] The message you wish to emit to the log
  #   file, useful for debugging.
  # @param force   [Boolean] When evaluates to true will attempt to
  #   write to the log file regardless of the Configuration setting.
  #
  # @example
  #   Vedeu.log('A useful debugging message: Error!')
  #
  # @return [TrueClass]
  def self.log(message, force = false)
    Vedeu::Log.logger.debug(message) if Configuration.debug? || force
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
require 'singleton'
require 'time'

require 'vedeu/support/common'
require 'vedeu/support/exceptions'
require 'vedeu/support/model'

require 'vedeu/configuration/cli'
require 'vedeu/configuration/api'
require 'vedeu/configuration/configuration'

require 'vedeu/support/log'
require 'vedeu/support/trace'

require 'vedeu/support/repository'
require 'vedeu/repositories/models/event'
require 'vedeu/repositories/events'
require 'vedeu/repositories/keymaps'
require 'vedeu/repositories/models/keymap'
require 'vedeu/api/keymap'
require 'vedeu/api/api'

require 'vedeu/colours/translator'
require 'vedeu/colours/background'
require 'vedeu/colours/foreground'
require 'vedeu/colours/colour'

require 'vedeu/support/coercions'
require 'vedeu/support/esc'
require 'vedeu/support/position'
require 'vedeu/support/presentation'
require 'vedeu/support/sentence'
require 'vedeu/support/terminal'

require 'vedeu/models/char'
require 'vedeu/models/composition'
require 'vedeu/models/geometry'
require 'vedeu/models/line'
require 'vedeu/models/stream'
require 'vedeu/models/style'

require 'vedeu/repositories/models/interface'
require 'vedeu/repositories/interfaces'

require 'vedeu/api/defined'
require 'vedeu/api/composition'
require 'vedeu/api/helpers'
require 'vedeu/api/interface'
require 'vedeu/api/line'
require 'vedeu/api/menu'
require 'vedeu/api/stream'

require 'vedeu/repositories/models/buffer'
require 'vedeu/repositories/models/cursor'
require 'vedeu/repositories/models/group'
require 'vedeu/repositories/models/menu'
require 'vedeu/repositories/models/offset'

require 'vedeu/support/keymap_validator'

require 'vedeu/repositories/buffers'
require 'vedeu/repositories/cursors'
require 'vedeu/repositories/focus'
require 'vedeu/repositories/groups'
require 'vedeu/repositories/menus'
require 'vedeu/repositories/offsets'

require 'vedeu/support/registrar'
require 'vedeu/support/refresh'

require 'vedeu/output/compositor'
require 'vedeu/output/output'
require 'vedeu/output/view'
require 'vedeu/output/viewport'

require 'vedeu/support/bounding_area'
require 'vedeu/support/grid'

require 'vedeu/input/input'

require 'vedeu/application'
require 'vedeu/launcher'

# Vedeu::Trace.call({ trace: true })
