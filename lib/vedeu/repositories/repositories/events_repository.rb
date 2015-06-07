module Vedeu

  # Allows the storing of events.
  class EventsRepository < Repository

    class << self

      # @return [Vedeu::EventsRepository]
      alias_method :events, :repository

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::EventsRepository]
      def reset!
        @events = new(Vedeu::Events)
      end

    end

  end # EventsRepository

end # Vedeu
