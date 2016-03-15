# frozen_string_literal: true

module Vedeu

  module Menus

    # Allows the storing of menus by name.
    #
    class Repository < Vedeu::Repositories::Repository

      real Vedeu::Menus::Menu
      null Vedeu::Menus::Menu

    end # Repository

  end # Menus

  # Manipulate the repository of menus.
  #
  # @example
  #   Vedeu.menus
  #
  # @api public
  # @!method menus
  # @return [Vedeu::Menus::Repository]
  def_delegators Vedeu::Menus::Repository,
                 :menus

end # Vedeu
