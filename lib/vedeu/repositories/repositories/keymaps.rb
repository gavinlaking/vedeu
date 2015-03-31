module Vedeu

  # Allows the storing of keymaps.
  #
  class Keymaps < Repository

    # @return [Vedeu::Keymaps]
    def self.keymaps
      @keymaps ||= reset!
    end

    def self.repository
      Vedeu.keymaps
    end

    def self.reset!
      @keymaps = Vedeu::Keymaps.new(Vedeu::Keymap)
    end

  end # Keymaps

end # Vedeu
