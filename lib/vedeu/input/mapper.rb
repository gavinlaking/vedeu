module Vedeu

  module Input

    # Maps keys to keymaps.
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
          Vedeu.trigger(:key, key)

          return false unless key

          new(key, name).keypress
        end

        def registered?(key = nil, name = nil)
          fail Vedeu::Error::MissingRequired,
               'Cannot check whether a key is registered to a keymap without ' \
               'the key.' if absent?(key)
          fail Vedeu::Error::MissingRequired,
               'Cannot check whether a key is registered to a keymap without ' \
               'the keymap name.' if absent?(name)

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

        return true if key_defined? && keymap.use(key)

        return true if global_key? && keymap('_global_').use(key)

        Vedeu.log(type: :input, message: "Key detected: #{key.inspect}".freeze)

        false
      end

      # Is the key defined in the named keymap?
      #
      # @param named [NilClass|String]
      # @return [Boolean]
      def key_defined?(named = name)
        keymap?(named) && keymap(named).key_defined?(key)
      end
      alias_method :registered?, :key_defined?

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

  # @!method keypress
  #   @see Vedeu::Input::Mapper.keypress
  def_delegators Vedeu::Input::Mapper, :keypress

  # :nocov:

  # See {file:docs/events/system.md#\_keypress_}
  Vedeu.bind(:_keypress_) { |key, name| Vedeu.keypress(key, name) }

  # See {file:docs/events/drb.md#\_drb_input_}
  Vedeu.bind(:_drb_input_) do |data, type|
    Vedeu.log(type: :drb, message: "Sending input (#{type})".freeze)

    case type
    when :command  then Vedeu.trigger(:_command_, data)
    when :keypress then Vedeu.trigger(:_keypress_, data)
    else Vedeu.trigger(:_keypress_, data)
    end
  end

  # See {file:docs/events/system.md#\_command_}
  Vedeu.bind(:_command_) { |command| Vedeu.trigger(:command, command) }

  # :nocov:

end # Vedeu
