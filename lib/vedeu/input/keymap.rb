require 'vedeu/repositories/all'
require 'vedeu/dsl/components/all'
require 'vedeu/input/key'

module Vedeu

  # A container class for keys associated with a particular interface.
  class Keymap

    include Vedeu::Model

    collection Vedeu::Keys
    member     Vedeu::Key

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # Returns a new instance of Vedeu::Keymap.
    #
    # @param attributes [Hash]
    # @option attributes name [String] The name of the keymap.
    # @option attributes keys [Vedeu::Keys|Array] A collection of keys.
    # @option attributes repository [Vedeu::Repository] This model's storage.
    # @return [Vedeu::Keymap]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    # @param key [Key]
    # @return [void]
    def add(key)
      return false unless valid?(key)

      @keys = keys.add(key)
    end

    # @return [Vedeu::Keys]
    def keys
      collection.coerce(@keys, self)
    end

    # @param input [String|Symbol]
    # @return [Boolean] A boolean indicating the input provided is already in
    #   use for this keymap.
    def key_defined?(input)
      keys.any? { |key| key.input == input }
    end

    # Triggers the action associated with the key, if it is registered with this
    # keymap.
    #
    # @param input [String|Symbol]
    # @return [Array|FalseClass]
    def use(input)
      return false unless key_defined?(input)

      Vedeu.log(type: :input, message: "Key pressed: '#{input}'")

      Vedeu.trigger(:key, input)

      keys.select { |key| key.input == input }.map(&:press)
    end

    private

    # @return [Hash]
    def defaults
      {
        name:       '',
        keys:       [],
        repository: Vedeu::Keymaps.keymaps,
      }
    end

    # Checks that the provided key is not already registered with this keymap.
    #
    # @param key [Vedeu::Key]
    # @return [Boolean]
    def valid?(key)
      return true unless key_defined?(key.input)

      Vedeu.log(type:    :debug,
                message: "Keymap '#{name}' already defines '#{key.input}'.")

      false
    end

  end # Keymap

end # Vedeu
