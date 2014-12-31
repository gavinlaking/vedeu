module Vedeu

  # The Focus repository is simply a collection of interface names, this module
  # serving to store and manipulate the which interface is currently being
  # focussed.
  #
  # @api private
  module Focus

    include Repository
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

      elsif focus
        storage.unshift(name)

      else
        storage.push(name)

      end
    end

    # Focus an interface by name. Used after defining an interface or interfaces
    # to set the initially focussed interface.
    #
    # @param name [String] The interface to focus; must be defined.
    # @raise [ModelNotFound] When the interface cannot be found.
    # @return [String] The name of the interface now in focus.
    def by_name(name)
      fail ModelNotFound unless registered?(name)

      storage.rotate!(storage.index(name))

      update
    end

    # Return the interface currently focussed.
    #
    # @raise [NoInterfacesDefined] When no interfaces are defined, we cannot
    #   make one focussed.
    # @return [String]
    def current
      fail NoInterfacesDefined if empty?

      storage.first
    end

    # Return the cursor for the currently focussed interface or an empty string
    # if no interfaces are defined.
    #
    # @note The client application may elect to have the cursor hidden for the
    #   currently focussed interface.
    #
    # @return [String] The escape sequence to render the cursor as shown or
    #   hidden.
    def cursor
      return '' if empty?

      Interface.new(Interfaces.find(current)).cursor.to_s
    end

    # Returns a boolean indicating whether the named interface is focussed.
    #
    # @param name [String]
    # @return [Boolean]
    def current?(name)
      current == name
    end

    # Put the next interface relative to the current interfaces in focus.
    #
    # @return [String]
    def next_item
      storage.rotate!

      update
    end
    alias_method :next, :next_item

    # Put the previous interface relative to the current interface in focus.
    #
    # @return [String]
    def prev_item
      storage.rotate!(-1)

      update
    end
    alias_method :prev,     :prev_item
    alias_method :previous, :prev_item

    # Refresh the interface in focus.
    #
    # @return [Array]
    def refresh
      Vedeu.trigger("_refresh_#{current}_".to_sym)
    end

    private

    # Return the name of the interface in focus after triggering the refresh
    # event for that interface. Returns false if the storage is empty.
    #
    # @return [String|FalseClass]
    def update
      return false if empty?

      Vedeu.log("Interface in focus: '#{current}'")

      refresh

      current
    end

    # Returns an empty collection ready for the storing of interface names.
    #
    # @return [Array]
    def in_memory
      []
    end

  end # Focus

end # Vedeu
