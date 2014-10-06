module Vedeu

  # The Focus repository is simply a collection of interface names, this module
  # serving to store and manipulate the which interface is currently being
  # focussed.
  #
  # @api private
  module Focus

    include Common
    include Repository
    extend self

    # System events which when called will change which interface is currently
    # focussed. When the interface is brought into focus, its cursor position
    # and visibility is restored.
    Vedeu.event(:_focus_by_name_) do |name|
      Vedeu::Focus.by_name(name)
      Vedeu.trigger(:_cursor_refresh_)
    end

    Vedeu.event(:_focus_next_) do
      Vedeu::Focus.next_item
      Vedeu.trigger(:_cursor_refresh_)
    end

    Vedeu.event(:_focus_prev_) do
      Vedeu::Focus.prev_item
      Vedeu.trigger(:_cursor_refresh_)
    end

    # Add an interface name to the focus list unless it is already registered.
    #
    # @param attributes [String]
    # @return [Array]
    def add(attributes)
      validate_attributes!(attributes)

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

      Vedeu.log("Interface in focus: '#{current}'")

      current
    end

    # Return the interface currently focussed.
    #
    # @return [String]
    def current
      fail NoInterfacesDefined if storage.empty?

      storage.first
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

      Vedeu.log("Interface in focus: '#{current}'")

      current
    end

    # Put the previous interface relative to the current interface in focus.
    #
    # @return [String]
    def prev_item
      storage.rotate!(-1)

      Vedeu.log("Interface in focus: '#{current}'")

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

    private

    # Returns an empty collection ready for the storing of interface names.
    #
    # @api private
    # @return [Array]
    def in_memory
      []
    end

  end # Focus

end # Vedeu
