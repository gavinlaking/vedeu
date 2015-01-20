module Vedeu

  # When included into a class, provides the mechanism to store the class in a
  # repository for later retrieval.
  #
  # @api private
  module Model

    attr_reader :repository

    # Returns a DSL instance responsible for defining the DSL methods of this
    # model.
    #
    # @return [void] The DSL instance for this model.
    def deputy
      Object.const_get(dsl_class).new(self)
    end

    # @return [void] The model instance stored in the repository.
    def store
      repository.store(self) # if valid?
    end

    private

    # Removes the module part from the expression in the string.
    #
    # @example
    #   demodulize('Vedeu::DSL::Interface') # => "Interface"
    #
    # @param klass [Class|String]
    def demodulize(klass)
      klass = klass.to_s

      klass[(klass.rindex('::') + 2)..-1]
    end

    # Returns the DSL class name responsible for this model.
    #
    # @return [String]
    def dsl_class
      'Vedeu::DSL::' + demodulize(self.class.name)
    end

  end # Model

end # Vedeu
