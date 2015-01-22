require 'vedeu/exceptions'
require 'vedeu/support/common'
require 'vedeu/models/model'
require 'vedeu/dsl/keymap'

module Vedeu

  class Keymap

    include Vedeu::Common
    include Vedeu::Model

    attr_accessor :name
    attr_reader   :keys

    class << self

      # Define actions for keypresses for when specific interfaces are in focus.
      # Unless an interface is specified, the key will be assumed to be global,
      # meaning its action will happen regardless of the interface in focus.
      #
      # @param name [String] The name of the interface which this keymap relates
      #   to.
      # @param block [Proc]
      #
      # @example
      #   keymap 'my_interface' do
      #     ...
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Keymap]
      def build(name, &block)
        unless block_given?
          fail InvalidSyntax, "'#{__callee__}' requires a block."
        end

        model = new(name)
        model.deputy.instance_eval(&block)
        model.store
      end
      alias_method :keymap, :build

    end

    # @param name [String] The name of the keymap.
    # @param keys [Vedeu::Model::Collection|Array] A collection of keys.
    # @return [Vedeu::Keymap]
    def initialize(name, keys = [], repository = nil)
      @name       = name
      @keys       = Vedeu::Model::Collection.coerce(keys)
      @repository = repository || Vedeu.keymaps
    end

    # @param key [Key]
    def add(key)
      @keys << key if valid?(key)

      # immutable Keymap version:
      # self.new(name, @keys += [key]).store if valid?(key)
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
    def valid?(key)
      if key_defined?(key.input)
        Vedeu.log("Keymap '#{name}' already defines '#{key.input}'.")

        false
      end

      true
    end

  end # Keymap

end # Vedeu
