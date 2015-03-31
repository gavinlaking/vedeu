module Vedeu

  # Allows the storing of events.
  #
  class EventsRepository < Repository

    # @return [Vedeu::EventsRepository]
    def self.events
      @events ||= reset!
    end

    def self.repository
      Vedeu.events
    end

    def self.reset!
      @events = Vedeu::EventsRepository.new(Vedeu::Events)
    end

  end # EventsRepository

end # Vedeu
