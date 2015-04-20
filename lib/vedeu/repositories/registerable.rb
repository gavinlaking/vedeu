module Vedeu

  # Repositories contain registerables, this module provides convenience methods
  # for them.
  module Registerable

    # These class methods are mixed into the repository.
    module ClassMethods

      # @param klass [Class]
      # @return [Symbol]
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
