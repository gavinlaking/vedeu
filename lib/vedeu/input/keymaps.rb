module Vedeu

  # Allows the storing of keymaps.
  #
  class Keymaps < Vedeu::Repository

    class << self

      alias_method :keymaps, :repository

    end # Eigenclass

    real Vedeu::Keymap

  end # Keymaps

end # Vedeu
