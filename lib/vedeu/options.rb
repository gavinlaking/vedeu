module Vedeu

  # @api private
  #
  module Options

    # @param name [String|Symbol]
    # @param value [void]
    # @return [void]
    def option(name, value = nil)
      define_method(name) do
        @__data__.fetch(name, value)
      end
    end

    # @api private
    #
    module InstanceMethods

      # @param data [Hash]
      # @return [void] An instance of the class extending this module.
      def initialize(data)
        @__data__ = data
      end

      # @return [Hash]
      def __data__
        @__data__
      end

    end # InstanceMethods

    # When this module is extended in a class, provide InstanceMethods
    # as instance methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.extended(klass)
      klass.include(InstanceMethods)
    end

  end # Options

end # Vedeu
