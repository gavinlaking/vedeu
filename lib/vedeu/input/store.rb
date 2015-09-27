module Vedeu

  module Input

    # Stores each keypress or command to be retrieved later.
    #
    class Store

      def initialize
      end

      # @return [Hash<Symbol => Array<Symbol|String>>]
      def add_command(command)
        all_commands << command
      end

      # @return [Hash<Symbol => Array<Symbol|String>>]
      def add_keypress(keypress)
        all_keypresses << keypress
      end

      # @return [Hash<Symbol => Array<Symbol|String>>]
      def all
        storage
      end

      # @return [Array<Symbol|String>]
      def all_commands
        storage[:commands]
      end

      # @return [Array<Symbol|String>]
      def all_keypresses
        storage[:keypresses]
      end

      # @return [NilClass|Symbol|String]
      def last_command
        all_commands.last
      end

      # @return [NilClass|Symbol|String]
      def last_keypress
        all_keypresses.last
      end

      # @return [Hash<Symbol => Array<Symbol|String>>]
      def reset
        @storage = in_memory
      end

      private

      # @return [Hash<Symbol => Array<Symbol|String>>]
      def storage
        @storage ||= in_memory
      end

      # @return [Hash<Symbol => Array<Symbol|String>>]
      def in_memory
        {
          commands:   [],
          keypresses: [],
        }
      end

    end # Store

  end # Input

end # Vedeu
