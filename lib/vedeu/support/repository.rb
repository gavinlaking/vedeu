module Vedeu

  module Repository

    # Return the whole repository.
    #
    # @return [Hash]
    def all
      storage
    end

    # Find the entity attributes by name.
    #
    # @param name [String]
    # @return [Hash]
    def find(name)
      storage.fetch(name) { not_found(name) }
    end

    # Returns a collection of the names of all the registered entities.
    #
    # @return [Array]
    def registered
      storage.keys
    end

    # Returns a boolean indicating whether the named entity is registered.
    #
    # @param name [String]
    # @return [Boolean]
    def registered?(name)
      storage.key?(name)
    end

    # Reset the repository.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory
    end

  end # Repository

end # Vedeu
