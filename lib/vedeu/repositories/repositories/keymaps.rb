module Vedeu

  # Allows the storing of keymaps.
  #
  class Keymaps < Repository

    class << self

      # @return [Vedeu::Keymaps]
      def keymaps
        @keymaps ||= reset!
      end
      alias_method :repository, :keymaps

      # @return [Vedeu::Keymaps]
      def reset!
        @keymaps = Vedeu::Keymaps.new(Vedeu::Keymap)
      end

    end

  end # Keymaps

end # Vedeu
