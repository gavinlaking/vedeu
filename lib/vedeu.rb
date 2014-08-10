require 'vedeu/instrumentation'

require 'vedeu/api/events'
require 'vedeu/api/grid'
require 'vedeu/api/interface'
require 'vedeu/api/line'
require 'vedeu/api/store'
require 'vedeu/api/stream'
require 'vedeu/api/view'
require 'vedeu/output/view'

require 'vedeu/support/menu'
require 'vedeu/launcher'

module Vedeu
  extend API

  def self.log(message)
    Vedeu::Instrumentation::Log.logger.debug(message)
  end

  def self.error(exception)
    Vedeu::Instrumentation::Log.error(exception)
  end

  def self.included(receiver)
    receiver.send(:include, API)
    receiver.extend(API)
  end
end
