module Vedeu

  module Models

    # Allows the storing of interfaces and views.
    #
    class Interfaces < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :interfaces, :repository)

      null Vedeu::Null::Interface
      real Vedeu::Models::Interface

      # Returns the interfaces in zindex order.
      #
      # @example
      #   Vedeu.interfaces.zindexed
      #
      # @return [Array<Vedeu::Models::Interface>]
      # @see Vedeu::DSL::Interface#zindex
      def zindexed
        all.sort_by(&:zindex)
      end

    end # Interfaces

    class Interface

      repo Vedeu::Models::Interfaces.repository

    end # Interface

  end # Models

  # Manipulate the repository of interfaces.
  #
  # @example
  #   Vedeu.interfaces
  #
  # @!method interfaces
  # @return [Vedeu::Models::Interfaces]
  def_delegators Vedeu::Models::Interfaces, :interfaces

end # Vedeu
