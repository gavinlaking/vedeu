require_relative '../repository/event_repository'

module Vedeu
  class Exit
    def self.dispatch
      EventRepository.trigger(:_exit_)
    end
  end
end
