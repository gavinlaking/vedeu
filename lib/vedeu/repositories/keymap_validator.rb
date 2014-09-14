module Vedeu

  # Validates that a given key is can be used and is not already in-use, either
  # by the same interface, globally or as a system key.
  #
  class KeymapValidator

    include Common

    # Checks the key is not in use by the system, is not already defined as a
    # global key, is not already defined for the interface specified.
    #
    # @param storage [Hash]
    # @param key [String|Symbol]
    # @param interface [String]
    # @return [Array] A boolean indicating validity, and a helpful message.
    def self.check(storage, key, interface = '')
      new(storage, key, interface).check
    end

    # Instantiates a new KeymapValidator instance.
    #
    # @param storage [Hash]
    # @param key [String|Symbol]
    # @param interface [String]
    # @return [KeymapValidator]
    def initialize(storage, key, interface = '')
      @storage, @key, @interface = storage, key, interface
    end

    # @see KeymapValidator.check
    def check
      if system_key?(key)
        [false, 'Cannot register key as already in use by the system.']

      elsif global_key?(key)
        [false, 'Cannot register key as already in use as a global key.']

      elsif interface_key?(key, interface)
        if defined_value?(interface)
          [false, 'Cannot register key as already in use by this interface.']

        else
          [false, 'Cannot register key as a global key as it is already ' \
                  ' registered to an interface.']

        end
      else
        [true, 'Key can be registered.']

      end
    end

    private

    attr_reader :storage, :key, :interface

    # Returns a boolean indicating whether the key has been registered for the
    # named interface's keymap. If no interface is specified, then it is
    # assumed that the key is attempting to be registered globally, and so all
    # interfaces are checked for this key. (A key cannot be global if an
    # interface is using it.)
    #
    # @param key [String|Symbol]
    # @param interface [String]
    # @return [Boolean]
    def interface_key?(key, interface = '')
      if defined_value?(interface)
        return false unless storage.key?(interface)

        storage.fetch(interface).keys.include?(key)

      else
        storage.keys.reject do |keymap|
          keymap == '_global_keymap_'
        end.map { |name| storage[name].keys.include?(key) }.any?

      end
    end

    # Returns a boolean indicating whether the key is in the global keymap.
    #
    # @param key [String|Symbol]
    # @return [Boolean]
    def global_key?(key)
      storage.fetch('_global_keymap_').keys.include?(key)
    end

    # Returns a boolean indicating whether the key is in the system keymap.
    # At present, it is not possible to redefine system keys.
    #
    # @param key [String|Symbol]
    # @return [Boolean]
    def system_key?(key)
      Configuration.system_keys.values.include?(key)
    end

  end

end
