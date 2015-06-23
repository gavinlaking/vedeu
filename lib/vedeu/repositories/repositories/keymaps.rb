module Vedeu

  # Allows the storing of keymaps.
  #
  # @api public
  class Keymaps < Repository

    class << self

      # @example
      #   Vedeu.keymaps
      #
      # @return [Vedeu::Keymaps]
      alias_method :keymaps, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.keymaps.reset!
      #
      # @return [Vedeu::Keymaps]
      def reset!
        @keymaps = register(Vedeu::Keymap)
      end

    end

  end # Keymaps

end # Vedeu
