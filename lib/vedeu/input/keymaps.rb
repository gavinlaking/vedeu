module Vedeu

  module Input

    # Allows the storing of keymaps.
    #
    class Keymaps < Vedeu::Repository

      singleton_class.send(:alias_method, :keymaps, :repository)

      real Vedeu::Input::Keymap

    end # Keymaps

  end # Input

end # Vedeu
