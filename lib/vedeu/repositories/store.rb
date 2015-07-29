module Vedeu

  # Provides generic repository related behaviour.
  #
  module Store

    include Enumerable

    # @param block [Proc]
    # @return [Enumerator]
    def each(&block)
      storage.each(&block)
    end

    # Return a boolean indicating whether the storage is empty.
    #
    # @return [Boolean]
    def empty?
      storage.empty?
    end

    # Returns a boolean indicating whether the named model is registered.
    #
    # @param name [String]
    # @return [Boolean]
    def exists?(name)
      return false if empty? || name.nil? || name.empty?

      storage.include?(name)
    end
    alias_method :registered?, :exists?

    # Returns a collection of the names of all the registered entities.
    #
    # @return [Array]
    def registered
      return []           if empty?
      return storage.keys if storage.is_a?(Hash)
      return storage.to_a if storage.is_a?(Set)

      storage
    end

    # Remove all currently stored data.
    #
    # @return [Array|Hash|Set]
    def reset
      Vedeu.log(type:    :reset,
                message: "(#{self.class.name}) #{registered.inspect}")

      @storage = in_memory
    end
    alias_method :reset!, :reset
    alias_method :clear, :reset

    # Return the number of entries stored.
    #
    # @return [Fixnum]
    def size
      storage.size
    end

    # Return whole repository; provides raw access to the storage for this
    # repository.
    #
    # @return [Array|Hash|Set]
    def storage
      @storage ||= in_memory
    end
    alias_method :all, :storage

    # @return [Hash]
    def in_memory
      {}
    end

  end # Store

end # Vedeu
