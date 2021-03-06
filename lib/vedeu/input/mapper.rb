# frozen_string_literal: true

module Vedeu

  module Input

    # Maps keys to keymaps.
    #
    # @api private
    #
    class Mapper

      class << self

        include Vedeu::Common

        # Takes a key as a keypress and sends it to registered
        # keymaps. If found, the associated action is fired,
        # otherwise, we move to the next keymap or return false.
        #
        # @example
        #   Vedeu.keypress(key_name, keymap_name)
        #
        # @param (see #initialize)
        # @return [Boolean]
        def keypress(key = nil, name = nil)
          new(key, name).keypress
        end

        # @param key [String|Symbol] The keypress.
        # @macro param_name
        # @macro raise_missing_required
        # @return [Boolean]
        def registered?(key = nil, name = nil)
          raise Vedeu::Error::MissingRequired,
                'Cannot check whether a key is registered to a keymap ' \
                'without the key.' if absent?(key)
          raise Vedeu::Error::MissingRequired,
                'Cannot check whether a key is registered to a keymap ' \
                'without the keymap name.' if absent?(name)

          new(key, name).registered?
        end

        # Checks a key is valid; i.e. not already registered to a
        # keymap. When the key is registered, then the key is invalid
        # and cannot be used again.
        #
        # @param (see #initialize)
        # @return [Boolean]
        def valid?(key = nil, name = nil)
          return false unless key

          new(key, name).valid?
        end

      end # Eigenclass

      # Returns a new instance of Vedeu::Input::Mapper.
      #
      # @param key [NilClass|String|Symbol]
      # @macro param_name
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
        Vedeu.trigger(:key, key)

        return false unless key

        return true if key_defined? && keymap.use(key)

        return true if global_key? && keymap('_global_').use(key)

        Vedeu.log(type: :input, message: log_message(key))

        false
      end

      # Is the key defined in the named keymap?
      #
      # @param named [NilClass|String]
      # @return [Boolean]
      def key_defined?(named = name)
        keymap?(named) && keymap(named).key_defined?(key)
      end
      alias registered? key_defined?

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
      # @return [NilClass|String|Symbol|Vedeu::Cursors::Cursor]
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

      # @param key [NilClass|String|Symbol|Vedeu::Cursors::Cursor]
      # @return [String]
      def log_message(key)
        if key.is_a?(Vedeu::Cursors::Cursor)
          "Click detected: x: #{key.x} y: #{key.y}"

        else
          "Key detected: #{key.inspect}"

        end
      end

      # With a name, we check the keymap with that name, otherwise we
      # use the name of the interface currently in focus.
      #
      # @return [String|NilClass]
      def name
        @name || Vedeu.focus
      end
      alias interface name

    end # Mapper

  end # Input

  # @api public
  # @!method keypress
  #   @see Vedeu::Input::Mapper.keypress
  def_delegators Vedeu::Input::Mapper,
                 :keypress

end # Vedeu
