
# load order is important

require 'vedeu/version'
require 'vedeu/exceptions'
require 'vedeu/debug'
require 'vedeu/traps'

require 'vedeu/null/all'
require 'vedeu/geometry/all'
require 'vedeu/repositories/all'

require 'vedeu/api'
require 'vedeu/bindings/drb'
require 'vedeu/bindings/menus'
require 'vedeu/bindings/bindings'

require 'vedeu/cli/generator/all'

# load order has not been fully established beyond this point

require 'vedeu/buffers/all'
require 'vedeu/configuration/all'
require 'vedeu/cursor/all'
require 'vedeu/distributed/all'

require 'vedeu/dsl/all'

require 'vedeu/events/all'
require 'vedeu/input/all'
require 'vedeu/output/all'
require 'vedeu/support/all'
require 'vedeu/templating/all'

require 'vedeu/main_loop'
require 'vedeu/application'
require 'vedeu/launcher'

require 'vedeu/application/all'

require 'vedeu/bootstrap'

require 'vedeu/cli/all'
