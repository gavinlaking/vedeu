module Vedeu

  class Keymap

    include Vedeu::Common
    include Vedeu::Model

    attr_reader :name

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
        model
      end
      alias_method :keymap, :build

    end

    def initialize(name, keymap = {})
      @name   = name
      @keymap = keymap
    end

    def define(key, action)
      if valid?(key, action)
        Keymap.new(keymap.merge({ key => action }), name).store
      end
    end

    def defined?(key)
      keymap.include?(key)
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Keymap]
    def deputy
      Vedeu::DSL::Keymap.new(self)
    end

    def keys
      keymap.keys
    end

    def use(key)
      if defined?(key)
        Vedeu.log("Key pressed: '#{key}'")

        Vedeu.trigger(:key, key)

        action.call
      end
    end

    private

    attr_reader :keymap

    def action
      keymap.fetch(key)
    end

    def repository
      Vedeu::Keymaps
    end

    def valid?(key, action)
      if defined?(key)
        fail KeyInUse, "'#{key}' is already in use for this ('#{name}') keymap."
      end

      unless action.respond_to?(:call)
        fail InvalidSyntax "Action for '#{key}' is not callable."
      end

      true
    end

  end # UserKeymap

end # Vedeu
