module Vedeu

  # Maps keys to keymaps.
  class Mapper

    # Takes a key as a keypress and sends it to registered keymaps. If found,
    # the associated action is fired, if not, we move to the next keymap or
    # return false.
    #
    # @param key [NilClass|String|Symbol]
    # @param name [NilClass|String]
    # @return [Boolean]
    def self.keypress(key = nil, name = nil)
      return false unless key

      new(key, name).keypress
    end

    # Checks a key is valid; i.e. not already registered to a keymap. If the
    # key is registered, then the key is invalid and cannot be used again.
    #
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

      return true if global_key? && keymap(global).use(key)

      return true if system_key? && keymap(system).use(key)

      false
    end

    # @return [Boolean]
    def valid?
      return false unless key

      return false if key_defined? || global_key? || system_key?

      true
    end

    private

    attr_reader :key, :repository

    # @return [Boolean]
    def global_key?
      key_defined?(global)
    end

    # @return [Boolean]
    def system_key?
      key_defined?(system)
    end

    # @param named [NilClass|String]
    # @return [Boolean]
    def key_defined?(named = name)
      keymap?(named) && keymap(named).key_defined?(key)
    end

    # @param named [NilClass|String]
    # @return [Keymap]
    def keymap(named = name)
      repository.find(named)
    end

    # @param named [NilClass|String]
    # @return [Boolean]
    def keymap?(named = name)
      repository.registered?(named)
    end

    # With a name, we check the keymap with that name, otherwise we use the
    # name of the interface currently in focus.
    #
    # @return [String|NilClass]
    def name
      @name || Vedeu.focus
    end
    alias_method :interface, :name

    # Return the name of the global keymap.
    #
    # @return [String]
    def global
      '_global_'
    end

    # Return the name of the system keymap.
    #
    # @return [String]
    def system
      '_system_'
    end

  end # Mapper

end # Vedeu
