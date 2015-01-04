require 'vedeu/models/carousel'

module Vedeu

  # The Focus repository is simply a collection of interface names, this class
  # serving to store and manipulate the which interface is currently being
  # focussed.
  #
  # @api private
  class Focus

    def initialize(carousel = nil)
      @carousel = carousel || Carousel.new
    end

    # Add an interface name to the focus list unless it is already registered.
    #
    # @param name [String] The name of the interface.
    # @param focus [Boolean] When true, prepends the interface name to the
    #   collection, making that interface the currently focussed interface.
    # @return [Array] The collection of interface names.
    def add(name, focus = false)
      @carousel = @carousel.add(name, focus)

      update
    end

    # Focus an interface by name. Used after defining an interface or interfaces
    # to set the initially focussed interface.
    #
    # @param name [String] The interface to focus; must be defined.
    # @raise [ModelNotFound] When the interface cannot be found.
    # @return [String] The name of the interface now in focus.
    def by_name(name)
      @carousel = @carousel.by_element(name)

      update
    end
    alias_method :focus, :by_name

    # Return the interface currently focussed.
    #
    # @raise [NoInterfacesDefined] When no interfaces are defined, we cannot
    #   make one focussed.
    # @return [String]
    def current
      @carousel.current
    end

    # Returns a boolean indicating whether the named interface is focussed.
    #
    # @param name [String]
    # @return [Boolean]
    def current?(name)
      @carousel.current?(name)
    end

    # Put the next interface relative to the current interfaces in focus.
    #
    # @return [String]
    def next_item
      @carousel = @carousel.next_item

      update
    end
    alias_method :next, :next_item

    # Put the previous interface relative to the current interface in focus.
    #
    # @return [String]
    def prev_item
      @carousel = @carousel.prev_item

      update
    end
    alias_method :prev,     :prev_item
    alias_method :previous, :prev_item

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

    # Refresh the interface in focus.
    #
    # @return [Array]
    def refresh
      Vedeu.trigger("_refresh_#{current}_".to_sym)
    end

    def reset
      @carousel = Carousel.new
    end

  end # Focus

end # Vedeu
