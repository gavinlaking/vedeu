require 'vedeu/exceptions'
require 'vedeu/models/model'
require 'vedeu/dsl/components/keymap'

module Vedeu

  class Keymap

    include Vedeu::Model

    collection Vedeu::Keys
    member     Vedeu::Key

    attr_accessor :name

    class << self

      # @param attributes [Hash]
      # @param block [Proc]
      # @option attributes client []
      # @option attributes keys []
      # @option attributes name []
      # @option attributes repository []
      # @return [Vedeu::Keymap]
      def build(attributes = {}, &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        attributes = defaults.merge(attributes)

        model = new(attributes[:name],
                    attributes[:keys],
                    attributes[:repository])
        model.deputy(attributes[:client]).instance_eval(&block)
        model.store
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client:     nil,
          keys:       [],
          name:       '',
          repository: Vedeu::Keymaps.keymaps,
        }
      end

    end

    # @param name [String] The name of the keymap.
    # @param keys [Vedeu::Model::Collection|Array] A collection of keys.
    # @return [Vedeu::Keymap]
    def initialize(name = '', keys = [], repository = nil)
      @name       = name
      @keys       = keys
      @repository = repository || Vedeu::Keymaps.keymaps
    end

    # @param key [Key]
    # @return []
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

    # @param input [String|Symbol]
    # @return [Array|FalseClass]
    def use(input)
      return false unless key_defined?(input)

      Vedeu.log("Key pressed: '#{input}'")

      Vedeu.trigger(:key, input)

      keys.select { |key| key.input == input }.map(&:press)
    end

    private

    # @param key [Vedeu::Key]
    # @return [Boolean]
    def valid?(key)
      return true unless key_defined?(key.input)

      Vedeu.log("Keymap '#{name}' already defines '#{key.input}'.")

      false
    end

  end # Keymap

end # Vedeu
