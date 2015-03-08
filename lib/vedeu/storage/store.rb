module Vedeu

  module Store

    include Enumerable

    # @param block [Proc]
    # @return [Enumerator]
    def each(&block)
      storage.each(&block)
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

    # Return a boolean indicating whether the storage is empty.
    #
    # @return [Boolean]
    def empty?
      storage.empty?
    end

    # Remove all currently stored data.
    #
    # @return [Array|Hash|Set]
    def reset
      @storage = in_memory
    end

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

  end # Store

end # Vedeu
