require 'vedeu/null/interface'
require 'vedeu/models/interface'

module Vedeu

  # Allows the storing of interfaces and views.
  #
  # @api public
  class Interfaces < Repository

    class << self

      alias_method :interfaces, :repository

    end # Eigenclass

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
      all.sort { |a, b| a.zindex <=> b.zindex }
    end

  end # Interfaces

  class Interface

    repo Vedeu::Interfaces.repository

  end # Interface

end # Vedeu
