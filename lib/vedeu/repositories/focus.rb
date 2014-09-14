module Vedeu

  # The Focus repository is simply a collection of interface names, this module
  # serving to store and manipulate the which interface is currently being
  # focussed.
  #
  # @api private
  module Focus

    extend self

    # System events which when called will change which interface is currently
    # focussed.
    Vedeu.event(:_focus_by_name_) { |name| Vedeu::Focus.by_name(name) }
    Vedeu.event(:_focus_next_)    { Vedeu::Focus.next_item    }
    Vedeu.event(:_focus_prev_)    { Vedeu::Focus.prev_item    }

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

      Vedeu.log("Interface in focus: '#{storage.first}'")

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

    # Returns a boolean indicating whether the named interface is registered.
    #
    # @api private
    # @return [Boolean]
    def registered?(name)
      return false if storage.empty?

      storage.include?(name)
    end

    # Reset the focus repository; removing all items. This does not delete
    # the interfaces themselves.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    private

    # Access to the storage for this repository.
    #
    # @api private
    # @return [Array]
    def storage
      @_storage ||= in_memory
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
