module Vedeu

  # Converts an options Hash into a class containing methods for each of the
  # keys, which when called returns the value associated. When the value is
  # either true or false, an additional predicate method is created.
  #
  # @api private
  class Options

    # @!attribute [r] _defined
    # @return [Array<Symbol>]
    attr_reader :_defined

    # @param options [Hash]
    # @return [Vedeu::Options]
    def self.build(options = {})
      new(options)._build
    end

    # Returns a new instance of Vedeu::Options.
    #
    # @param options [Hash]
    # @return [Vedeu::Options]
    def initialize(options = {})
      @_options = options
      @_defined = []
    end

    # @return [Vedeu::Options]
    def _build
      _options.each do |name, value|
        _create_method(name) { value }

        if value.is_a?(TrueClass) || value.is_a?(FalseClass)
          _create_alias("#{name}?", name)
        end
      end

      self
    end

    protected

    # @!attribute [r] _options
    # @return [Hash]
    attr_reader :_options

    private

    # @param alias_name [String|Symbol]
    # @param method_name [String|Symbol]
    # @return [void]
    def _create_alias(alias_name, method_name)
      @_defined << alias_name.to_sym

      define_singleton_method(alias_name, method(method_name))
    end

    # @param name [String|Symbol]
    # @param block [Proc]
    # @return [void]
    def _create_method(name, &block)
      @_defined << name.to_sym

      self.class.send(:define_method, name, &block)
    end

  end # Option

end # Vedeu
