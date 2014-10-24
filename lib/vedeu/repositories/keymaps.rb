module Vedeu

  # Repository for storing, retrieving and using defined keymaps.
  #
  # @api private
  module Keymaps

    include Common
    include Repository
    extend self

    # Stores the keymap attributes defined by the API.
    #
    # @param attributes [Hash]
    # @option attributes :interfaces [Array] A list of the names of interfaces for which the
    #   keys are active for.
    # @option attributes :keys [Array] A collection of key/action pairs.
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

    # Find a keymap by named interface. Return an empty collection when there =
    # are no specific keys defined for the named interface.
    #
    # @param name [String]
    # @return [Hash]
    def find(name)
      storage.fetch(name, {})
    end

    # Return a boolean indicating whether the key is registered as a global key.
    #
    # @param key [String|Symbol]
    # @return [Boolean]
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
    # @return [Boolean]
    def interface_key?(key, interface = '')
      if defined_value?(interface)
        find(interface).keys.include?(key)

      else
        interface_keys.include?(key)

      end
    end

    # Return a collection of interface keys. When the optional 'name' parameter
    # is provided, then only the keys associated with that interface are
    # returned.
    #
    # @param interface [String]
    # @return [Hash]
    def interface_keys(interface = nil)
      return find(interface).keys if interface

      storage.reject do |k, _|
        k == '_global_keymap_'
      end.map { |_, v| v.keys }.flatten.uniq
    end

    # Return a boolean indicating whether the key is registered as a system key.
    #
    # @param key [String|Symbol]
    # @return [Boolean]
    def system_key?(key)
      system_keys.include?(key)
    end

    # Return the collection of system keys.
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
      Vedeu.log("Key pressed: '#{key}'")

      Vedeu.trigger(:key, key)

      focussed_interface = Vedeu::Focus.current

      if interface_key?(key, focussed_interface)
        find(focussed_interface).fetch(key, noop).call(:noop_interface)

      elsif global_key?(key)
        find('_global_keymap_').fetch(key, noop).call(:noop_global)

      elsif system_key?(key)
        system_key(key)

      else
        false

      end
    end
    alias_method :keypress, :use

    private

    # Triggers the system event defined for this key.
    #
    # @param key [String|Symbol]
    # @return [] The result(s) of triggering the event.
    def system_key(key)
      action = Vedeu::Configuration.system_keys.key(key)
      event  = ['_', action, '_'].join.to_sym

      Vedeu.trigger(event)
    end

    # Registers the key.
    #
    # @param attributes [Hash]
    # @param interface [String]
    # @return []
    def register(attributes, interface = '_global_keymap_')
      attributes[:keys].map do |keymap|
        KeymapValidator.check(storage, keymap[:key], interface)

        Vedeu.log("Registering key: '#{keymap[:key]}' with '#{interface}'")

        storage[interface].merge!({ keymap[:key] => keymap[:action] })
      end
    end

    # Returns a noop proc which when called returns the argument or :noop.
    #
    # @param value [Symbol]
    # @return [Proc]
    def noop(value = :noop)
      proc { value }
    end

    # @return [Hash]
    def in_memory
      {
        '_global_keymap_' => {}
      }
    end

  end # Keymaps

end # Vedeu
