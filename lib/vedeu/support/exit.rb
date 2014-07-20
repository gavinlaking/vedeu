require_relative '../repository/event_repository'

module Vedeu
  class Exit
    def self.dispatch
      Trigger.event(:_exit_)
    end
  end
end
