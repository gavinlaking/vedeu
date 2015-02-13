require 'vedeu/events/event'
require 'vedeu/events/trigger'

module Vedeu

  # @return [Vedeu::Repository]
  def self.events
    @_events ||= Vedeu::Repository.new(Vedeu::Model::Collection)
  end

end # Vedeu
