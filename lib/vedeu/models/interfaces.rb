module Vedeu

  # Allows the storing of interfaces and views.
  #
  class Interfaces < Vedeu::Repository

    singleton_class.send(:alias_method, :interfaces, :repository)

    null Vedeu::Null::Interface
    real Vedeu::Interface

    # Returns the interfaces in zindex order.
    #
    # @example
    #   Vedeu.interfaces.zindexed
    #
    # @return [Array<Vedeu::Interface>]
    # @see Vedeu::DSL::Interface#zindex
    def zindexed
      all.sort_by(&:zindex)
    end

  end # Interfaces

  class Interface

    repo Vedeu::Interfaces.repository

  end # Interface

end # Vedeu
