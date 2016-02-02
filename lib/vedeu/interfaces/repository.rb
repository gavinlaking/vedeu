# frozen_string_literal: true

module Vedeu

  module Interfaces

    # Allows the storing of interfaces and views.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :interfaces, :repository)

      null Vedeu::Interfaces::Null
      real Vedeu::Interfaces::Interface

      # Returns the interfaces in zindex order.
      #
      # @example
      #   Vedeu.interfaces.zindexed
      #
      # @return [Array<Vedeu::Interfaces::Interface>]
      # @see Vedeu::Interfaces::DSL#zindex
      def zindexed
        all.sort_by(&:zindex)
      end

    end # Interfaces

    class Interface

      repo Vedeu::Interfaces::Repository.repository

    end # Interface

  end # Interfaces

  # Manipulate the repository of interfaces.
  #
  # @example
  #   Vedeu.interfaces
  #
  # @api public
  # @!method interfaces
  # @return [Vedeu::Interfaces::Repository]
  def_delegators Vedeu::Interfaces::Repository,
                 :interfaces

end # Vedeu
