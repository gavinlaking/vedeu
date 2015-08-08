module Vedeu

  # Allows the storing of events.
  #
  class Events < Vedeu::Repository

    singleton_class.send(:alias_method, :events, :repository)

    class << self

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.events.reset!
      #
      # @return [Vedeu::Events]
      def reset!
        @events = new(Vedeu::EventCollection)
      end
      alias_method :reset, :reset!

    end # Eigenclass

  end # Events

end # Vedeu
