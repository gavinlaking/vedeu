module Vedeu

  module Input

    # Allows the storing of keymaps.
    #
    class Keymaps < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :keymaps, :repository)

      real Vedeu::Input::Keymap

    end # Keymaps

  end # Input

  # Manipulate the repository of keymaps.
  #
  # @example
  #   Vedeu.keymaps
  #
  # @!method keymaps
  # @return [Vedeu::Input::Keymaps]
  def_delegators Vedeu::Input::Keymaps, :keymaps

end # Vedeu
