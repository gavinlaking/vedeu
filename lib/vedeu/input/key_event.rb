module Vedeu

  class KeyEvent

    # @param name []
    # @param key []
    # @return []
    def self.trigger(name, key)
      new(name, key).trigger
    end

    # @param name []
    # @param key []
    # @return []
    def initialize(name, key)
      @name = name
      @key  = key
      @repository = Vedeu.keymaps
    end

    # @return [Boolean]
    def trigger
      if exists?
        use

      else
        discard

      end
    end

    private

    attr_reader :name, :key, :repository

    # @return [FalseClass]
    def discard
      false
    end

    # @return [TrueClass]
    def use
      keymap(name).use(key)

      true
    end

    # @return []
    def exists?
      keymap?(name) && keymap(name).key_defined?(key)
    end

    # @param name []
    # @return []
    def keymap(name)
      @keymap ||= repository.find(name)
    end

    # @param name []
    # @return []
    def keymap?(name)
      repository.registered?(name)
    end

  end # KeyEvent

end # Vedeu
