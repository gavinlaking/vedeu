module Vedeu

  # Allows the storing of events.
  #
  # @api public
  class EventsRepository < Repository

    class << self

      # @example
      #   Vedeu.events
      #
      # @return [Vedeu::EventsRepository]
      alias_method :events, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.events.reset
      #
      # @return [Vedeu::EventsRepository]
      def reset!
        @events = new(Vedeu::Events)
      end

    end

  end # EventsRepository

end # Vedeu
