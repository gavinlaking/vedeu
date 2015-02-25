
# load order is important

require 'vedeu/debug'
require 'vedeu/traps'
require 'vedeu/exceptions'

require 'vedeu/repositories/all'

require 'vedeu/api'
require 'vedeu/bindings'

# load order has not been fully established beyond this point

require 'vedeu/buffers/all'
require 'vedeu/configuration/all'
require 'vedeu/cursor/all'
require 'vedeu/distributed/all'

require 'vedeu/dsl/shared/all'
require 'vedeu/dsl/all'

require 'vedeu/events/all'
require 'vedeu/input/all'
require 'vedeu/models/all'
require 'vedeu/output/all'
require 'vedeu/presentation/all'
require 'vedeu/support/all'

require 'vedeu/main_loop'
require 'vedeu/application'
require 'vedeu/launcher'
