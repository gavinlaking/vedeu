module Vedeu

  # Maintains which interface by name is current in focus.
  module Focus

    extend self

    # Register events which allow the control of which interface should be
    # focussed.
    #
    # @api private
    # Vedeu.event(:_focus_next_)    { Focus.next_item }
    # Vedeu.event(:_focus_prev_)    { Focus.prev_item }
    # Vedeu.event(:_focus_by_name_) { |name| Focus.by_name(name) }

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

    # @api private
    # @return [Array]
    def storage
      @storage ||= in_memory
    end

    # @api private
    # @return [Array]
    def in_memory
      []
    end

  end
end
