require 'vedeu/support/common'

module Vedeu

  # A Keymap is the binding of a keypress to one or more interfaces; or globally
  # to perform a client application defined action.
  #
  # @api private
  class Keymap

    include Vedeu::Common
    include Model

    attr_reader :attributes

    # Define actions for keypresses for when specific interfaces are in focus.
    # Unless an interface is specified, the key will be assumed to be global,
    # meaning its action will happen regardless of the interface in focus.
    #
    # @param name_or_names [String] The name or names of the interface(s) which
    #   will handle these keys.
    # @param block [Proc]
    #
    # @example
    #   keys do                    # => will be global
    #     key('s') { :something }
    #     ...
    #
    #   keys 'my_interface' do     # => will only function when 'my_interface'
    #     ...                      #    is in focus
    #
    #   keys('main', 'other') do   # => will function for both 'main' and
    #     ...                      #    'other' interfaces
    #
    #   keys do
    #     interface 'my_interface' # => will only function when 'my_interface'
    #     ...                      #    is in focus
    #
    # @raise [InvalidSyntax] When the required block is not given.
    # @return [Keymap]
    def self.keys(*name_or_names, &block)
      return Vedeu.requires_block(__callee__) unless block_given?

      define({ interfaces: name_or_names }, &block)
    end

    # Define a keymap for an interface or interfaces to perform an action when
    # a key is pressed whilst an aforementioned interface is in focus.
    #
    # @param attributes [Hash] The attributes to register the keymap with.
    # @option attributes :interfaces [] the interface(s) which will respond to
    #   the keypress(es)
    # @option attributes :keys [] the keypress/action pairs for this keymap
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
      @attributes = defaults.merge(attributes)
    end

    # Adds the attributes to the Keymaps repository.
    #
    # @param block [Proc]
    # @return [Keymap]
    def define(&block)
      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end

      repository.add(attributes)

      self
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Keymap]
    def deputy
      Vedeu::DSL::Keymap.new(self)
    end

    private

    # @return [Class] The repository class for this model.
    def repository
      Vedeu::Keymaps
    end

    # The default attributes of the Keymap model.
    #
    # @return [Hash]
    def defaults
      {
        interfaces: [],
        keys:       [],
      }
    end

  end # Keymap

end # Vedeu
