module Vedeu

  module Keymaps

    include Vedeu::Common
    extend self

    # Stores the keymap attributes defined by the API.
    #
    # @param attributes [Hash]
    # @return [TrueClass|KeyInUse|FalseClass]
    def add(attributes)
      return false unless defined_value?(attributes[:keys])

      if defined_value?(attributes[:interfaces])
        attributes[:interfaces].map do |interface|
          storage.store(interface, {}) unless registered?(interface)

          register(attributes, interface)
        end

      else
        register(attributes)

      end

      true
    end

    # Return the whole repository of keymaps.
    #
    # @return [Hash]
    def all
      storage
    end

    # Find a keymap by interface name.
    #
    # @param name [String]
    # @return [Hash|FalseClass]
    def find(name)
      storage.fetch(name, false)
    end

    # Returns a collection of the interface names of all the registered keymaps.
    #
    # @return [Array]
    def registered
      storage.keys
    end

    # Returns a boolean indicating whether the named interface has a keymap
    # registered.
    #
    # @param name [String]
    # @return [TrueClass|FalseClass]
    def registered?(name)
      storage.key?(name)
    end

    # Reset the keymaps repository; removing all registered keymaps. Only the
    # system keymap will remain.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    # A key has been pressed. Determine if the key pertains to the focussed
    # interface and action it, or check both global, then system keys to action
    # it. Discards the keypress if nothing can deal with it.
    #
    # @param key [String|Symbol]
    # @return []
    def use(key)
      interface_keys = find(Vedeu::Focus.current)
      global_keys    = find('_global_keymap_')
      system_keys    = Configuration.system_keys

      if interface_keys && interface_keys.keys.include?(key)
        interface_keys[key].call

      elsif global_keys && global_keys.keys.include?(key)
        global_keys[key].call

      elsif system_keys && system_keys.values.include?(key)
        system_keys.key(key).call

      else
        # key not recognised, do nothing...

      end
    end

    # Triggers the system event defined for this key.
    #
    # @param key [String|Symbol]
    # @return []
    def system_key(key)
      action = Vedeu::Configuration.system_keys.key(key)
      event  = ['_', action, '_'].join.to_sym
      Vedeu.trigger(event)
    end

    private

    # @param key [String|Symbol]
    # @param interface [String]
    # @return []
    def validate(key, interface = '')
      Vedeu::KeymapValidator.check(storage, key, interface)
    end

    # Registers the key.
    #
    # @api private
    # @param attributes [Hash]
    # @param interface [String]
    # @return []
    def register(attributes, interface = '')
      attributes[:keys].map do |keymap|
        valid, message = validate(keymap[:key], interface)

        fail KeyInUse, message unless valid

        namespace = defined_value?(interface) ? interface : '_global_keymap_'

        storage[namespace].merge!({ keymap[:key] => keymap[:action] })
      end
    end

    # Access to the storage for this repository.
    #
    # @api private
    # @return [Array]
    def storage
      @_storage ||= in_memory
    end

    # @api private
    # @return [Array]
    def in_memory
      { '_global_keymap_' => {} }
    end

  end

end
