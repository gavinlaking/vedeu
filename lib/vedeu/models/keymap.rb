module Vedeu

  # A Keymap is the binding of a keypress to one or more interfaces; or globally
  # to perform a client application defined action.
  class Keymap

    include Common

    attr_reader :attributes

    # Define a keymap for an interface or interfaces to perform an action when
    # a key is pressed whilst an aforementioned interface is in focus.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Keymap]
    def self.define(attributes = {}, &block)
      new(attributes).define(&block)
    end

    # Instantiate a new instance of the Keymap model.
    #
    # @param attributes [Hash]
    # @return [Keymap]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
    end

    # Adds the attributes to the Keymaps repository.
    #
    # @param block [Proc]
    # @return [Interface]
    def define(&block)
      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end

      Keymaps.add(attributes)

      self
    end

    private

    # The default attributes of the Keymap model.
    #
    # @api private
    # @return [Hash]
    def defaults
      {
        interfaces: [], # the interface(s) which will respond to the keypress(es)
        keys: [], # the keypress/action pairs for this keymap
      }
    end

    # @api private
    # @return []
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end

end
