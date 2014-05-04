require 'io/console'
require 'singleton'
require 'timeout'

require_relative 'vedeu/colour/base'
require_relative 'vedeu/colour/foreground'
require_relative 'vedeu/colour/background'

require_relative 'vedeu/colour/mask'
require_relative 'vedeu/colour/translator'

require_relative 'vedeu/composition/grid'
require_relative 'vedeu/composition/row'

require_relative 'vedeu/input/character/multibyte'
require_relative 'vedeu/input/character/standard'
require_relative 'vedeu/input/keyboard'
require_relative 'vedeu/input/parser'
require_relative 'vedeu/input/translator'

require_relative 'vedeu/interface'
require_relative 'vedeu/dummy_interface'
require_relative 'vedeu/application'
require_relative 'vedeu/buffer'
require_relative 'vedeu/clock'
require_relative 'vedeu/d_buffer'
require_relative 'vedeu/esc'
require_relative 'vedeu/interfaces'
require_relative 'vedeu/position'

require_relative 'vedeu/renderer'
require_relative 'vedeu/terminal'
require_relative 'vedeu/version'
