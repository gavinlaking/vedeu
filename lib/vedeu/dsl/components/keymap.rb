require 'vedeu/exceptions'
require 'vedeu/support/common'
require 'vedeu/input/key'

module Vedeu

  module DSL

    # Provides methods to be used to define keypress mapped to actions.
    #
    # @api public
    class Keymap

      include Vedeu::Common
      include Vedeu::DSL

      # Returns an instance of DSL::Keymap.
      #
      # @param model [Keymap]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Define keypress(es) to perform an action.
      #
      # @param value_or_values [Array<String>|Array<Symbol>|String|Symbol]
      #   The key(s) pressed. Special keys can be found in
      #   {Vedeu::Input#specials}. When more than one key is defined, then the
      #   extras are treated as aliases.
      # @param block [Proc] The action to perform when this key is pressed. Can
      #   be a method call or event triggered.
      #
      # @example
      #   Vedeu.keymap do
      #     key('s')        { Vedeu.trigger(:save) }
      #     key('h', :left) { Vedeu.trigger(:left) }
      #     key('j', :down) { Vedeu.trigger(:down) }
      #     key('p') do
      #       ...
      #     end
      #     ...
      #
      # @raise [InvalidSyntax] When the required block is not given, the
      #   value_or_values parameter is undefined, or when processing the
      #   collection, a member is undefined.
      # @return [Array] A collection containing the keypress(es).
      def key(*value_or_values, &block)
        fail InvalidSyntax, 'No action defined for `key`.' unless block_given?

        unless defined_value?(value_or_values)
          fail InvalidSyntax, 'No keypress(es) defined for `key`.'
        end

        value_or_values.each do |value|
          unless defined_value?(value)
            fail InvalidSyntax, 'An invalid value for `key` was encountered.'
          end

          unless model.key_defined?(value)
            model.add(model.member.build(value, &block))
          end
        end
      end

      # Define the name of the keymap.
      #
      # To only allow certain keys to work with specific interfaces, use the
      # same name as the interface.
      #
      # When the name '_global_' is used, all keys in the keymap block will be
      # available to all interfaces. Once a key has been defined in the
      # '_global_' keymap, it cannot be used for a specific interface.
      #
      # @note Using the name of a keymap that already exists will overwrite that
      #   keymap. Do not use the name '_system_' as unexpected behaviour may
      #   occur.
      #
      # @param value [String]
      # @return [String]
      def name(value)
        model.name = value
      end

      private

      attr_reader :client, :model

    end # Keymap

  end # DSL

end # Vedeu
