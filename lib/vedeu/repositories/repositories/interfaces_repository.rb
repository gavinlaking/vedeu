module Vedeu

  # Allows the storing of interfaces and views.
  #
  # @api public
  class InterfacesRepository < Repository

    class << self

      # @example
      #   Vedeu.interfaces
      #
      # @return [Vedeu::InterfacesRepository]
      alias_method :interfaces, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.interfaces.reset!
      #
      # @return [Vedeu::InterfacesRepository]
      def reset!
        @interfaces = register(Vedeu::Interface)
      end

    end

    null Vedeu::Null::Interface
    # real Vedeu::Interface

    # Returns the interfaces in zindex order.
    #
    # @example
    #   Vedeu.interfaces.zindexed
    #
    # @return [Array<Vedeu::Interface>]
    # @see Vedeu::DSL::Interface#zindex
    def zindexed
      all.sort { |a, b| a.zindex <=> b.zindex }
    end

  end # InterfacesRepository

end # Vedeu
