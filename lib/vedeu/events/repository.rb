module Vedeu

  module Events

    # Allows the storing of events.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :events, :repository)

      class << self

        # Remove all stored models from the repository.
        #
        # @example
        #   Vedeu.events.reset!
        #
        # @return [Vedeu::Events::Repository]
        def reset!
          @events = new(Vedeu::Events::Collection)
        end
        alias_method :reset, :reset!

      end # Eigenclass

    end # Repository

  end # Events

  # Manipulate the repository of events.
  #
  # @example
  #   Vedeu.events
  #
  # @!method events
  # @return [Vedeu::Events::Repository]
  def_delegators Vedeu::Events::Repository,
                 :events

end # Vedeu
