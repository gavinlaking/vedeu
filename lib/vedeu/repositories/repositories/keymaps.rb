module Vedeu

  # Allows the storing of keymaps.
  #
  # @api public
  class Keymaps < Repository

    class << self

      # @return [Vedeu::Keymaps]
      alias_method :keymaps, :repository

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Keymaps]
      def reset!
        @keymaps = register(Vedeu::Keymap)
      end

    end

  end # Keymaps

end # Vedeu
