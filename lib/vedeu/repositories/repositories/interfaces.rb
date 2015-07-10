module Vedeu

  # Allows the storing of interfaces and views.
  #
  # @api public
  class Interfaces < Repository

    class << self

      alias_method :interfaces, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.interfaces.reset!
      #
      # @return [Vedeu::Interfaces]
      def reset!
        @interfaces = register(Vedeu::Interface)
      end
      alias_method :reset, :reset!

    end # Eigenclass

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

  end # Interfaces

end # Vedeu
