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

    # Return a boolean indicating whether the key is registered as a global key.
    #
    # @param key [String|Symbol]
    # @return [TrueClass|FalseClass]
    def global_key?(key)
      global_keys.include?(key)
    end

    # Return the collection of global keys.
    #
    # @return [Array]
    def global_keys
      storage.fetch('_global_keymap_', {}).keys
    end

    # Return a boolean indicating whether the key is registered as an interface
    # key. When an interface argument is provided, only that interface is
    # checked.
    #
    # @param key [String|Symbol]
    # @param interface [String]
    # @return [TrueClass|FalseClass]
    def interface_key?(key, interface = '')
      if defined_value?(interface)
        find(interface).keys.include?(key)

      else
        interface_keys.include?(key)

      end
    end

    # Return a collection of interface keys.
    #
    # @return [Hash]
    def interface_keys
      storage.reject do |k, _|
        k == '_global_keymap_'
      end.map { |_, v| v.keys }.flatten.uniq
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

    # Return a boolean indicating whether the key is registered as a system key.
    #
    # @param key [String|Symbol]
    # @return [TrueClass|FalseClass]
    def system_key?(key)
      system_keys.include?(key)
    end

    # Return a collection of system keys.
    #
    # @return [Array]
    def system_keys
      Configuration.system_keys.invert.keys
    end

    # Handles the keypress in your application. Can also be used to simulate a
    # keypress.
    #
    # 1) Log the keypress if debugging is enabled.
    # 2) Trigger the client application's `:key` event (it may not exist).
    # 3) Determine if the key pertains to the focussed interface and action it,
    #    or check both global, then system keys to action it. Returns false if
    #    nothing can deal with it.
    #
    # @param key [String|Symbol] The key which was pressed. Escape sequences
    #   are also supported. Special keys like the F-keys are named as symbols;
    #   i.e. `:f4`. A list of these translations can be found at {Vedeu::Input}.
    #
    # @example
    #   Vedeu.keypress('s')
    #
    # @return [|FalseClass]
    def use(key)
      Vedeu.trigger(:_log_, "Key: #{key}") if Configuration.debug?
      Vedeu.trigger(:key, key)

      if interface_key?(key, Vedeu::Focus.current)
        find(Vedeu::Focus.current).fetch(key, noop).call

      elsif global_key?(key)
        find('_global_keymap_').fetch(key, noop).call

      elsif system_key?(key)
        system_key(key)

      else
        false

      end
    end

    private

    # Triggers the system event defined for this key.
    #
    # @param key [String|Symbol]
    # @return []
    def system_key(key)
      action = Vedeu::Configuration.system_keys.key(key)
      event  = ['_', action, '_'].join.to_sym

      Vedeu.trigger(event)
    end

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

    # Returns a noop proc which when called returns :noop.
    #
    # @return [Proc]
    def noop
      proc { :noop }
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
