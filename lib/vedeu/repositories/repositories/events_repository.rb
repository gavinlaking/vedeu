module Vedeu

  # Allows the storing of events.
  class EventsRepository < Repository

    class << self

      # @return [Vedeu::EventsRepository]
      def events
        @events ||= reset!
      end
      alias_method :repository, :events

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::EventsRepository]
      def reset!
        @events = Vedeu::EventsRepository.new(Vedeu::Events)
      end

    end

  end # EventsRepository

end # Vedeu
