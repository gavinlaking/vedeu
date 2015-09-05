module Vedeu

  # The Focus repository is simply a collection of interface names, this module
  # serving to store and manipulate the which interface is currently being
  # focussed.
  #
  # @note
  #   - Interfaces are added to the collection in the order they are defined.
  #   - If the interface definition contains `focus!`,
  #     (see Vedeu::DSL::Interface#focus!) then that interface is prepended to
  #     the list.
  #   - If the `Vedeu.focus_by_name 'some_interface'` declaration is used, then
  #     the list pointer (`current`) is set to the interface of that name.
  #
  module Focus

    extend self

    # Add an interface name to the focus list unless it is already registered.
    #
    # @param name [String] The name of the interface.
    # @param focus [Boolean] When true, prepends the interface name to the
    #   collection, making that interface the currently focussed interface.
    # @return [Array] The collection of interface names.
    def add(name, focus = false)
      if registered?(name)
        return storage unless focus

        by_name(name)
        storage

      else
        Vedeu.log(type: :store, message: "Storing focus entry: '#{name}'")

        if focus
          storage.unshift(name)

        else
          storage.push(name)

        end
      end
    end

    # Focus an interface by name. Used after defining an interface or interfaces
    # to set the initially focussed interface.
    #
    # @example
    #   Vedeu.focus_by_name('name')
    #
    # @param name [String] The interface to focus; must be defined.
    # @raise [Vedeu::Error::ModelNotFound] When the interface cannot be found.
    # @return [String] The name of the interface now in focus.
    def by_name(name)
      unless registered?(name)
        fail Vedeu::Error::ModelNotFound,
             "Cannot focus '#{name}' as this interface has not been registered."
      end

      storage.rotate!(storage.index(name))

      update
    end
    alias_method :focus_by_name, :by_name

    # Return the interface currently focussed.
    #
    # @example
    #   Vedeu.focus
    #
    # @return [String]
    def current
      storage[0]
    end
    alias_method :focus, :current

    # Returns a boolean indicating whether the named interface is focussed.
    #
    # @example
    #   Vedeu.focussed?(name)
    #
    # @param name [String]
    # @return [Boolean]
    def current?(name)
      current == name
    end
    alias_method :focussed?, :current?

    # Return a boolean indicating whether the storage is empty.
    #
    # @return [Boolean]
    def empty?
      storage.empty?
    end

    # Put the next interface relative to the current interfaces in focus.
    #
    # @example
    #   Vedeu.focus_next
    #
    # @return [String]
    def next_item
      storage.rotate!

      update
    end
    alias_method :next, :next_item

    # Put the next visible interface relative to the current interfaces in
    # focus.
    #
    # @return [String]
    def next_visible_item
      return update unless visible_items?

      loop do
        storage.rotate!
        break if Vedeu.interfaces.by_name(current).visible?
      end

      update
    end
    alias_method :focus_next, :next_visible_item

    # Put the previous interface relative to the current interface in focus.
    #
    # @example
    #   Vedeu.focus_previous
    #
    # @return [String]
    def prev_item
      storage.rotate!(-1)

      update
    end
    alias_method :prev,     :prev_item
    alias_method :previous, :prev_item

    # Put the previous visible interface relative to the current interfaces in
    # focus.
    #
    # @return [String]
    def prev_visible_item
      return update unless visible_items?

      loop do
        storage.rotate!(-1)
        break if Vedeu.interfaces.by_name(current).visible?
      end

      update
    end
    alias_method :focus_previous, :prev_visible_item

    # Refresh the interface in focus.
    #
    # @return [Array]
    def refresh
      Vedeu.trigger(:_refresh_, current)
    end

    # Returns a collection of the names of all the registered entities.
    #
    # @return [Array]
    def registered
      return [] if empty?

      storage
    end

    # Returns a boolean indicating whether the named model is registered.
    #
    # @param name [String]
    # @return [Boolean]
    def registered?(name)
      return false if empty?

      storage.include?(name)
    end

    # Reset the repository.
    #
    # @return [Array|Hash|Set]
    def reset
      @storage = in_memory
    end

    private

    # Return the name of the interface in focus after triggering the refresh
    # event for that interface. Returns false when the storage is empty.
    #
    # @return [String|FalseClass]
    def update
      return false if empty?

      Vedeu.log(type: :info, message: "Interface in focus: '#{current}'")

      refresh

      current
    end

    # Access to the storage for this repository.
    #
    # @return [Array]
    def storage
      @storage ||= in_memory
    end

    # Returns an empty collection ready for the storing of interface names.
    #
    # @return [Array]
    def in_memory
      []
    end

    # @return [Boolean]
    def visible_items?
      storage.any? { |name| Vedeu.interfaces.by_name(name).visible? }
    end

  end # Focus

end # Vedeu
