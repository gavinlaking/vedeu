module Vedeu

  module Input

    # Stores each keypress or command to be retrieved later.
    #
    module Store

      extend self

      # Add a command (a collection of characters/keypresses from an
      # Editor::Document) to the store. Used by Vedeu internally to
      # store commands entered.
      #
      # @example
      #   Vedeu.add_command(:some_command)
      #
      # @param command [Symbol|String]
      # @return [Hash<Symbol => Array<Symbol|String>>]
      def add_command(command)
        all_commands << command
      end

      # Add a keypress to the store. Used by Vedeu internally to
      # store a keypress entered.
      #
      # @example
      #   Vedeu.add_keypress(:escape)
      #
      # @param keypress [Symbol|String]
      # @return [Hash<Symbol => Array<Symbol|String>>]
      def add_keypress(keypress)
        all_keypresses << keypress
      end

      # Access all commands stored.
      #
      # @example
      #   Vedeu.all_commands
      #
      # @return [Array<Symbol|String>]
      def all_commands
        storage[:commands]
      end

      # Access all keypresses stored.
      #
      # @example
      #   Vedeu.all_keypresses
      #
      # @return [Array<Symbol|String>]
      def all_keypresses
        storage[:keypresses]
      end

      # Access the last command stored. If no commands have been
      # entered since the client application started, then this will
      # return nil.
      #
      # @example
      #   Vedeu.last_command
      #
      # @return [NilClass|Symbol|String]
      def last_command
        all_commands[-1]
      end

      # Access the last keypress stored. If no keys have been pressed
      # since the client application started, then this will return
      # nil.
      #
      # @example
      #   Vedeu.last_keypress
      #
      # @return [NilClass|Symbol|String]
      def last_keypress
        all_keypresses[-1]
      end

      # Remove all stored entries. Any commands or keypresses entered
      # before calling this method will be removed.
      #
      # @return [Hash<Symbol => Array<Symbol|String>>]
      def reset!
        @storage = in_memory
      end
      alias_method :reset, :reset!

      # Access all commands and keypresses stored.
      #
      # @return [Hash<Symbol => Array<Symbol|String>>]
      def storage
        @storage ||= in_memory
      end
      alias_method :all, :storage

      private

      # @return [Hash<Symbol => Array<Symbol|String>>]
      def in_memory
        {
          commands:   [],
          keypresses: [],
        }
      end

    end # Store

  end # Input

  # @!method add_command
  #   @see Vedeu::Input::Store.add_command
  # @!method add_keypress
  #   @see Vedeu::Input::Store.add_keypress
  # @!method all_commands
  #   @see Vedeu::Input::Store.all_commands
  # @!method all_keypresses
  #   @see Vedeu::Input::Store.all_keypresses
  # @!method last_command
  #   @see Vedeu::Input::Store.last_command
  # @!method last_keypress
  #   @see Vedeu::Input::Store.last_keypress
  def_delegators Vedeu::Input::Store,
                 :add_command,
                 :add_keypress,
                 :all_commands,
                 :all_keypresses,
                 :last_command,
                 :last_keypress

end # Vedeu
