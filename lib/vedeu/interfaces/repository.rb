# frozen_string_literal: true

module Vedeu

  module Interfaces

    # Allows the storing of interfaces and views.
    #
    # @api private
    #
    class Repository < Vedeu::Repositories::Repository

      null Vedeu::Interfaces::Null
      real Vedeu::Interfaces::Interface

      # Returns the interface names in zindex order.
      #
      # @example
      #   Vedeu.interfaces.zindexed
      #
      # @return [Array<String|Symbol>]
      # @see Vedeu::Interfaces::DSL#zindex
      def zindexed
        all.sort_by(&:zindex).map(&:name)
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
