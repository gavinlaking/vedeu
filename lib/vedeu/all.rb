
# load order is important

require 'vedeu/version'
require 'vedeu/exceptions'
require 'vedeu/debug'
require 'vedeu/traps'

require 'vedeu/null/all'

require 'vedeu/geometry/area'
require 'vedeu/geometry/coordinate'
require 'vedeu/geometry/dimension'

require 'vedeu/geometry/geometry'
require 'vedeu/repositories/store'
require 'vedeu/repositories/registerable'
require 'vedeu/repositories/repository'
require 'vedeu/geometry/geometries'
require 'vedeu/geometry/grid'
require 'vedeu/geometry/index_position'
require 'vedeu/geometry/position_index'
require 'vedeu/geometry/position'
require 'vedeu/geometry/position_validator'

require 'vedeu/repositories/all'

require 'vedeu/api'
require 'vedeu/bindings/all'

require 'vedeu/cli/generator/all'

# load order has not been fully established beyond this point

require 'vedeu/buffers/buffers'
require 'vedeu/buffers/buffer'
require 'vedeu/buffers/display_buffer'

require 'vedeu/configuration/cli'
require 'vedeu/configuration/api'
require 'vedeu/configuration/configuration'

require 'vedeu/repositories/all'

require 'vedeu/cursor/cursor'
require 'vedeu/cursor/cursors'
require 'vedeu/cursor/move'
require 'vedeu/cursor/refresh_cursor'
require 'vedeu/cursor/reposition'

require 'vedeu/distributed/uri'
require 'vedeu/distributed/server'
require 'vedeu/distributed/client'
require 'vedeu/distributed/subprocess'
require 'vedeu/distributed/test_application'

require 'vedeu/dsl/all'

require 'vedeu/repositories/collection'

require 'vedeu/events/events'
require 'vedeu/events/event'
require 'vedeu/events/trigger'

require 'vedeu/input/all'

require 'vedeu/output/esc'
require 'vedeu/colours/colour_translator'
require 'vedeu/colours/background'
require 'vedeu/colours/foreground'
require 'vedeu/output/presentation'
require 'vedeu/output/borders'
require 'vedeu/output/border'
require 'vedeu/colours/colour'
require 'vedeu/output/compressor'

require 'vedeu/output/clear/named_group'
require 'vedeu/output/clear/named_interface'

require 'vedeu/output/style'
require 'vedeu/output/text'
require 'vedeu/output/virtual_buffer'
require 'vedeu/output/html_char'
require 'vedeu/output/refresh_group'
require 'vedeu/output/refresh'
require 'vedeu/output/renderers/all'
require 'vedeu/output/output'
require 'vedeu/output/viewport'
require 'vedeu/output/virtual_terminal'
require 'vedeu/output/wordwrap'

require 'vedeu/common'
require 'vedeu/log'
require 'vedeu/common'
require 'vedeu/terminal'
require 'vedeu/timer'

require 'vedeu/templating/helpers'
require 'vedeu/templating/directive'
require 'vedeu/templating/preprocessor'
require 'vedeu/templating/template'

require 'vedeu/main_loop'
require 'vedeu/application'
require 'vedeu/launcher'

require 'vedeu/application/controller'
require 'vedeu/application/helper'
require 'vedeu/application/view'
require 'vedeu/application/application_controller'
require 'vedeu/application/application_helper'
require 'vedeu/application/application_view'


require 'vedeu/bootstrap'

require 'vedeu/cli/main'
