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

      # Define actions for keypresses for when specific interfaces are in focus.
      # Unless an interface is specified, the key will be assumed to be global,
      # meaning its action will happen regardless of the interface in focus.
      #
      # @note
      #   When defining an interface, there is no need to provide a name since
      #   this can be discerned from the interface itself, e.g:
      #
      #   Vedeu.interface 'my_interface' do
      #     keymap do
      #       # ...
      #
      # @param name [String] The name of the interface which this keymap relates
      #   to.
      # @param block [Proc]
      #
      # @example
      #   Vedeu.keymap 'my_interface' do
      #     # ...
      #
      #   Vedeu.keys 'my_interface' do
      #     # ...
      #
      #   Vedeu.interface 'my_interface' do
      #     keymap do
      #       # ...
      #
      #   Vedeu.interface 'my_interface' do
      #     keys do
      #       # ...
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Keymap]
      # @todo Try to remember why we need to pre-create the keymap in the
      #   repository.
      def self.keymap(name, &block)
        Vedeu::Keymap.new(name: name).store

        Vedeu::Keymap.build({ name: name }, &block).store
      end

      # Returns an instance of DSL::Keymap.
      #
      # @param model [Keymap]
      # @param client [Object]
      # @return [Vedeu::DSL::Keymap]
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

          model.add(model.member.new(value, &block))
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

      protected

      # @!attribute [r] client
      # @return [Object]
      attr_reader :client

      # @!attribute [r] model
      # @return [Keymap]
      attr_reader :model

    end # Keymap

  end # DSL

end # Vedeu
