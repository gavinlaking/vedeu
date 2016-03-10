# frozen_string_literal: true

module Vedeu

  module Input

    # Allows the storing of keymaps.
    #
    class Repository < Vedeu::Repositories::Repository

      real Vedeu::Input::Keymap

    end # Repository

  end # Input

  # Manipulate the repository of keymaps.
  #
  # @example
  #   Vedeu.keymaps
  #
  # @api public
  # @!method keymaps
  # @return [Vedeu::Input::Repository]
  def_delegators Vedeu::Input::Repository,
                 :keymaps

end # Vedeu
