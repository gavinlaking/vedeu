require 'vedeu/events/event'
require 'vedeu/events/trigger'

module Vedeu

  def self.events
    @_events ||= Vedeu::Events.new(Vedeu::Model::Collection)
  end

end # Vedeu
