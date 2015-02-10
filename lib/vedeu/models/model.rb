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
    # @param client [Object|NilClass] The client binding represents
    #   the client application object that is currently invoking a DSL method.
    #   It is required so that we can send messages to the client application
    #   object should we need to.
    # @return [void] The DSL instance for this model.
    def deputy(client = nil)
      Object.const_get(dsl_class).new(self, client)
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
