# frozen_string_literal: true

module Vedeu

  module Input

    # Stores each keypress or command to be retrieved later.
    #
    module Store

      extend self
      extend Vedeu::Repositories::Storage

      # {include:file:docs/dsl/by_method/add_command.md}
      # @param command [Symbol|String]
      # @return [Hash<Symbol => Array<Symbol|String>>]
      def add_command(command)
        all_commands << command
      end

      # {include:file:docs/dsl/by_method/add_keypress.md}
      # @param keypress [Symbol|String]
      # @return [Hash<Symbol => Array<Symbol|String>>]
      def add_keypress(keypress)
        all_keypresses << keypress
      end

      # {include:file:docs/dsl/by_method/all_commands.md}
      # @return [Array<Symbol|String>]
      def all_commands
        storage[:commands]
      end

      # {include:file:docs/dsl/by_method/all_keypresses.md}
      # @return [Array<Symbol|String>]
      def all_keypresses
        storage[:keypresses]
      end

      # {include:file:docs/dsl/by_method/last_command.md}
      # @return [NilClass|Symbol|String]
      def last_command
        all_commands[-1]
      end

      # {include:file:docs/dsl/by_method/last_keypress.md}
      # @return [NilClass|Symbol|String]
      def last_keypress
        all_keypresses[-1]
      end

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
