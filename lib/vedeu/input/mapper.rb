module Vedeu

  module Input

    # Maps keys to keymaps.
    #
    class Mapper

      # Takes a key as a keypress and sends it to registered keymaps.
      # If found, the associated action is fired, otherwise, we move
      # to the next keymap or return false.
      #
      # @example
      #   Vedeu.keypress(key_name, keymap_name)
      #
      # @param (see #initialize)
      # @return [Boolean]
      def self.keypress(key = nil, name = nil)
        Vedeu.trigger(:key, key)

        return false unless key

        new(key, name).keypress
      end

      # Checks a key is valid; i.e. not already registered to a
      # keymap. When the key is registered, then the key is invalid
      # and cannot be used again.
      #
      # @param (see #initialize)
      # @return [Boolean]
      def self.valid?(key = nil, name = nil)
        return false unless key

        new(key, name).valid?
      end

      # Returns a new instance of Vedeu::Input::Mapper.
      #
      # @param key [NilClass|String|Symbol]
      # @param name [NilClass|String]
      # @param repository [NilClass|Vedeu::Repositories::Repository]
      # @return [Vedeu::Input::Mapper]
      def initialize(key = nil, name = nil, repository = nil)
        @key        = key
        @name       = name
        @repository = repository || Vedeu.keymaps
      end

      # Returns a boolean indicating that the key is registered to the
      # current keymap, or the global keymap.
      #
      # @return [Boolean]
      def keypress
        return false unless key

        Vedeu.log(type: :input, message: "Key detected: #{key.inspect}")

        return true if key_defined? && keymap.use(key)

        return true if global_key? && keymap('_global_').use(key)

        false
      end

      # Returns a boolean indicating that the key is not registered to
      # the current keymap, or the global keymap.
      #
      # @return [Boolean]
      def valid?
        return false if !key || key_defined? || global_key?

        true
      end

      protected

      # @!attribute [r] key
      # @return [String|Symbol]
      attr_reader :key

      # @!attribute [r] repository
      # @return [Vedeu::Repositories::Repository]
      attr_reader :repository

      private

      # Is the key a global key?
      #
      # @return [Boolean]
      def global_key?
        key_defined?('_global_')
      end

      # Is the key defined in the named keymap?
      #
      # @param named [NilClass|String]
      # @return [Boolean]
      def key_defined?(named = name)
        keymap?(named) && keymap(named).key_defined?(key)
      end

      # Fetch the named keymap from the repository.
      #
      # @param named [NilClass|String]
      # @return [Vedeu::Input::Keymap]
      def keymap(named = name)
        repository.find(named)
      end

      # Does the keymaps repository have the named keymap already
      # registered?
      #
      # @param named [NilClass|String]
      # @return [Boolean]
      def keymap?(named = name)
        repository.registered?(named)
      end

      # With a name, we check the keymap with that name, otherwise we
      # use the name of the interface currently in focus.
      #
      # @return [String|NilClass]
      def name
        @name || Vedeu.focus
      end
      alias_method :interface, :name

    end # Mapper

  end # Input

end # Vedeu
