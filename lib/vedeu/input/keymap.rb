# frozen_string_literal: true

module Vedeu

  module Input

    # A container class for keys associated with a particular
    # interface.
    #
    # @api private
    #
    class Keymap

      include Vedeu::Repositories::Model

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # Returns a new instance of Vedeu::Input::Keymap.
      #
      # @param attributes [Hash<Symbol => Array|String|Symbol|
      #   Vedeu::Input::Keys|Vedeu::Repositories::Repository>]
      # @option attributes name [String|Symbol] The name of the
      #   keymap.
      # @option attributes keys [Vedeu::Input::Keys|Array]
      #   A collection of keys.
      # @option attributes repository
      #   [Vedeu::Repositories::Repository] This model's storage.
      # @return [Vedeu::Input::Keymap]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Add a key to the keymap.
      #
      # @param key [Vedeu::Input::Key]
      # @return [void]
      def add(key)
        return false unless valid?(key)

        @keys = keys.add(key)
      end

      # Returns a DSL instance responsible for defining the DSL
      # methods of this model.
      #
      # @param client [Object|NilClass] The client binding represents
      #   the client application object that is currently invoking a
      #   DSL method. It is required so that we can send messages to
      #   the client application object should we need to.
      # @return [Vedeu::Input::DSL] The DSL instance for this model.
      def deputy(client = nil)
        Vedeu::Input::DSL.new(self, client)
      end

      # Returns the collection of keys defined for this keymap.
      #
      # @return [Vedeu::Input::Keys]
      def keys
        Vedeu::Input::Keys.coerce(@keys, self)
      end

      # Check whether the key is already defined for this keymap.
      #
      # @param input [String|Symbol]
      # @return [Boolean] A boolean indicating the input provided is
      #   already in use for this keymap.
      def key_defined?(input)
        keys.any? { |key| key.input == input }
      end

      # When the given input is registered with this keymap, this
      # method triggers the action associated with the key.
      #
      # @param input [String|Symbol]
      # @return [Array|Boolean]
      def use(input)
        return false unless key_defined?(input)

        Vedeu.log(type: :input, message: "Key pressed: '#{input}'")

        keys.select { |key| key.input == input }.map(&:press)
      end

      private

      # @macro defaults_method
      def defaults
        {
          name:       nil,
          keys:       [],
          repository: Vedeu.keymaps,
        }
      end

      # Checks that the provided key is not already registered with
      # this keymap.
      #
      # @param key [Vedeu::Input::Key]
      # @return [Boolean]
      def valid?(key)
        return true unless key_defined?(key.input)

        Vedeu.log(type:    :input,
                  message: "Keymap '#{name}' already " \
                           "defines '#{key.input}'.")

        false
      end

    end # Keymap

  end # Input

end # Vedeu
