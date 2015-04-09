module Vedeu

  # Allows the storing of keymaps.
  #
  class Keymaps < Repository

    # @return [Vedeu::Keymaps]
    def self.keymaps
      @keymaps ||= reset!
    end

    # @return [Vedeu::Keymaps]
    def self.repository
      Vedeu.keymaps
    end

    # @return [Vedeu::Keymaps]
    def self.reset!
      @keymaps = Vedeu::Keymaps.new(Vedeu::Keymap)
    end

  end # Keymaps

end # Vedeu
