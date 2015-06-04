module Vedeu

  # Allows the storing of keymaps.
  class Keymaps < Repository

    class << self

      # @return [Vedeu::Keymaps]
      def keymaps
        @keymaps ||= reset!
      end
      alias_method :repository, :keymaps

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Keymaps]
      def reset!
        @keymaps = register(Vedeu::Keymap)
      end

    end

  end # Keymaps

end # Vedeu
