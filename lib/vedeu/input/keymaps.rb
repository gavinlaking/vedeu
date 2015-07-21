require 'vedeu/input/keymap'

module Vedeu

  # Allows the storing of keymaps.
  #
  # @api public
  class Keymaps < Vedeu::Repository

    class << self

      alias_method :keymaps, :repository

    end # Eigenclass

    real Vedeu::Keymap

  end # Keymaps

end # Vedeu
