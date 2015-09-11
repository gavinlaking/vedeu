module Vedeu

  class Options

    # @param options [Hash]
    # @param defaults [Hash]
    def initialize(options = {}, defaults = {})
      @options  = options  || {}
      @defaults = defaults || {}

      @defaults.merge!(@options).each do |key, value|
        instance_variable_set("@#{key}", value)
        self.class.send(:define_method, key) { value }
      end
    end

  end # Options

end # Vedeu
