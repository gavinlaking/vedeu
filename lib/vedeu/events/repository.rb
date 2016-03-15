# frozen_string_literal: true

module Vedeu

  module Events

    # Allows the storing of events.
    #
    # @api private
    #
    class Repository < Vedeu::Repositories::Repository

      class << self

        # Remove all stored models from the repository.
        #
        # @example
        #   Vedeu.events.reset!
        #
        # @return [Vedeu::Events::Repository]
        def reset!
          @events = new(Vedeu::Events::Events)
        end
        alias reset reset!

      end # Eigenclass

    end # Repository

  end # Events

  # Manipulate the repository of events.
  #
  # @example
  #   Vedeu.events
  #
  # @api public
  # @!method events
  # @return [Vedeu::Events::Repository]
  def_delegators Vedeu::Events::Repository,
                 :events

end # Vedeu
