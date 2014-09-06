module Vedeu

  # The Focus repository is simply a collection of interface names, this module
  # serving to store and manipulate the which interface is currently being
  # focussed.
  #
  # @api private
  module Focus

    extend self

    # Add an interface name to the focus list unless it is already registered.
    #
    # @param attributes [String]
    # @return [Array]
    def add(attributes)
      if registered?(attributes[:name])
        storage

      else
        storage << attributes[:name]

      end
    end

    # Focus an interface by name.
    #
    # @param name [String]
    # @return [String]
    def by_name(name)
      fail InterfaceNotFound unless storage.include?(name)

      storage.rotate!(storage.index(name))

      current
    end

    # Return the interface currently focussed.
    #
    # @return [String]
    def current
      fail NoInterfacesDefined if storage.empty?

      storage.first
    end

    # Put the next interface relative to the current interfaces in focus.
    #
    # @return [String]
    def next_item
      storage.rotate!

      current
    end

    # Put the previous interface relative to the current interface in focus.
    #
    # @return [String]
    def prev_item
      storage.rotate!(-1)

      current
    end

    # Returns all registered interfaces by name.
    #
    # @return [Array]
    def registered
      storage
    end

    # Reset the focus repository; removing all items. This does not delete
    # the interfaces themselves.
    #
    # @return [Hash]
    def reset
      @storage = in_memory
    end

    private

    # Returns a boolean indicating whether the named interface is registered.
    #
    # @api private
    # @return [TrueClass|FalseClass]
    def registered?(name)
      return false if storage.empty?

      storage.include?(name)
    end

    # Provides accessor to the in-memory storage.
    #
    # @api private
    # @return [Array]
    def storage
      @storage ||= in_memory
    end

    # Returns an empty collection ready for the storing of interface names.
    #
    # @api private
    # @return [Array]
    def in_memory
      []
    end

  end
end
