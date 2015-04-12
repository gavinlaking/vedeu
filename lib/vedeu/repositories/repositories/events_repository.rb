module Vedeu

  # Allows the storing of events.
  #
  class EventsRepository < Repository

    class << self

      # @return [Vedeu::EventsRepository]
      def events
        @events ||= reset!
      end
      alias_method :repository, :events

      # @return [Vedeu::EventsRepository]
      def reset!
        @events = Vedeu::EventsRepository.new(Vedeu::Events)
      end

    end

  end # EventsRepository

end # Vedeu
