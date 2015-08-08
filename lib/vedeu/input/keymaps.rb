module Vedeu

  # Allows the storing of keymaps.
  #
  class Keymaps < Vedeu::Repository

    singleton_class.send(:alias_method, :keymaps, :repository)

    real Vedeu::Keymap

  end # Keymaps

end # Vedeu
