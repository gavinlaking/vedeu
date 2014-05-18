require 'hamster'
require 'io/console'
require 'singleton'

require_relative 'vedeu/support/terminal'

require_relative 'vedeu/output/base'
require_relative 'vedeu/output/background'
require_relative 'vedeu/output/compositor'
require_relative 'vedeu/output/foreground'
require_relative 'vedeu/output/esc'
require_relative 'vedeu/output/mask'
require_relative 'vedeu/output/translator'

require_relative 'vedeu/interface/interfaces'
require_relative 'vedeu/interface/interface'

require_relative 'vedeu/process/commands'
require_relative 'vedeu/process/command'
require_relative 'vedeu/process/process'

require_relative 'vedeu/application'
require_relative 'vedeu/version'
