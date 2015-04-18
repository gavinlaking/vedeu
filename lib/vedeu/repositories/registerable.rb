module Vedeu

  module Registerable

    module ClassMethods

      def null(klass)
        define_method(:null_model) { klass }
      end

    end # ClassMethods

    # When this module is included in a class, provide ClassMethods as class
    # methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.included(klass)
      klass.send :extend, ClassMethods
    end

  end # Registerable

end # Vedeu
