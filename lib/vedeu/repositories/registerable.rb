module Vedeu

  # Repositories contain registerables, this module provides convenience methods
  # for them.
  module Registerable

    # These class methods are mixed into the repository.
    module ClassMethods

      # The null model is used when the repository cannot be found.
      #
      # @param klass [Class]
      # @return [Symbol]
      def null(klass)
        define_method(:null_model) { klass }
      end

      # The real model is the usual model to use for a given repository.
      #
      # @param klass [Class]
      # @return [Symbol]
      def real(klass)
        define_method(:real_model) { klass }
      end

      # Register a repository for storing models.
      #
      # @param model [Class]
      # @param storage [Class|Hash]
      # @return [Vedeu::Repository]
      def register(model = nil, storage = {})
        new(model, storage).tap do |klass|
          Vedeu::Repositories.register(klass.repository)
        end
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
