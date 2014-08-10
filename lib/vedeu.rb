require 'vedeu/instrumentation'
require 'vedeu/api/interface'
require 'vedeu/api/events'
require 'vedeu/api/store'
require 'vedeu/api/view'
require 'vedeu/models/geometry'
require 'vedeu/support/menu'
require 'vedeu/output/view'
require 'vedeu/launcher'

# Todo: mutation (events)

module Vedeu
  # :nocov:
  def self.debug?
    false
  end

  Vedeu::Instrumentation::Trace.call if debug?

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

  extend API
  # :nocov:
end
