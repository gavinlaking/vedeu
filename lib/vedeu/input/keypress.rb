module Vedeu

  class Keypress

    # @param key [String]
    # @return [Array]
    def self.keypress(key)
      new(key).keypress
    end

    # @param key [String]
    # @return [Keypress]
    def initialize(key)
      @key = key
    end

    # @return [Array]
    def keypress
      keymaps.each { |keymap| break if Vedeu::KeyEvent.trigger(keymap, key) }
    end

    private

    attr_reader :key

    # @return [Array]
    def keymaps
      [interface, global, system].compact
    end

    # @return [String]
    def interface
      Vedeu.focus
    end

    # @return [String]
    def global
      '_global_'
    end

    # @return [String]
    def system
      '_system_'
    end

  end # Keypress

end # Vedeu
