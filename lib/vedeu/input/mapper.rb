module Vedeu

  class Mapper

    # @param key [NilClass|String|Symbol]
    # @param name [NilClass|String]
    # @return [Boolean]
    def self.keypress(key = nil, name = nil)
      return false unless key

      new(key, name).keypress
    end

    # @param key [NilClass|String|Symbol]
    # @param name [NilClass|String]
    # @return [Boolean]
    def self.valid?(key = nil, name = nil)
      return false unless key

      new(key, name).valid?
    end

    # @param key [NilClass|String|Symbol]
    # @param name [NilClass|String]
    # @param repository [NilClass|Repository]
    # @return [Mapper]
    def initialize(key = nil, name = nil, repository = nil)
      @key        = key
      @name       = name
      @repository = repository || Vedeu.keymaps
    end

    # @return [Boolean]
    def keypress
      return false unless key

      return true if key_defined? && keymap.use(key)

      return true if key_defined?(global) && keymap(global).use(key)

      return true if key_defined?(system) && keymap(system).use(key)

      false
    end

    # @return [Boolean]
    def valid?
      return false unless key

      return false if key_defined?

      return false if key_defined?(global)

      return false if key_defined?(system)

      true
    end

    private

    attr_reader :key, :name, :repository

    # @param named [NilClass|String]
    # @return [Boolean]
    def key_defined?(named = name)
      keymap?(named) && keymap(named).key_defined?(key)
    end

    # @param named [NilClass|String]
    # @return [Keymap]
    def keymap(named = name)
      @keymap ||= repository.find(named)
    end

    # @param named [NilClass|String]
    # @return [Boolean]
    def keymap?(named = name)
      repository.registered?(named)
    end

    # @note
    #   With no name or a lack of interface in focus, we remove this entry and
    #   only check the global and system keymaps.
    #
    # @return [Array]
    def keymaps
      [interface, global, system].compact
    end

    # Return a boolean indicating that a named keymap was provided, or there is
    # an interface currently in focus.
    #
    # @return [Boolean]
    def interface?
      !!(interface)
    end

    # With a name, we check the keymap with that name, otherwise we use the
    # name of the interface currently in focus.
    #
    # @return [String|NilClass]
    def interface
      name || Vedeu.focus
    end

    # @return [String]
    def global
      '_global_'
    end

    # @return [String]
    def system
      '_system_'
    end

  end # Mapper

end # Vedeu
