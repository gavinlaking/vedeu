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
      # @raise [InvalidSyntax] When the required block is not given.
      # @return [Keymap]
      def build(name = '_global_', &block)
        return requires_block(__callee__) unless block_given?

        model = new(name)
        model.deputy.instance_eval(&block)
        model.store
      end
      alias_method :keymap, :build

    end

    # @param name [String] The name of the keymap.
    # @param keys [Vedeu::Model::Collection|Array] A collection of keys.
    # @return [Vedeu::Keymap]
    def initialize(name, keys = [])
      @name = name
      @keys = Vedeu::Model::Collection.coerce(keys)
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Keymap]
    def deputy
      Vedeu::DSL::Keymap.new(self)
    end

    # @param key [Key]
    # @raise [KeyInUse] The key provided is already in use for this keymap.
    def add(key)
      @keys << [key] if valid?(key)

      # immutable Keymap version:
      # self.new(name, @keys += [key]).store if valid?(key)
    end

    # @param input [String|Symbol]
    # @return [Boolean] A boolean indicating the input provided is already in
    #   use for this keymap.
    def key_defined?(input)
      # keys.find_all { |key| key.input == input }.any?

      keys.any? { |key| key.input == input }
    end

    # @param input [String|Symbol]
    def use(input)
      if key_defined?(input)
        Vedeu.log("Key pressed: '#{input}'")

        Vedeu.trigger(:key, input)

        keys.find_all { |key| key.input == input }.map { |key| key.press }
      end
    end

    private

    def repository
      Vedeu.keymaps_repository
    end

    # @param key [Vedeu::Key]
    def valid?(key)
      if key_defined?(key.input)
        fail KeyInUse, "'#{key.input}' is already in use for this " \
                       "('#{name}') keymap."
      end

      true
    end

  end # Keymap

end # Vedeu
