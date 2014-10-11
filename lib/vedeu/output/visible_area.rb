module Vedeu

  # Returns the geometry for visible area of the interface.
  #
  class VisibleArea

    # Return an instance of VisibleArea
    #
    # @param interface [Interface]
    # @return [VisibleArea]
    def initialize(interface)
      @interface = interface
    end

    # Return an Area representing the geometry of this interface.
    #
    # @return [Area]
    def geometry
      @_geometry ||= Area.new({
        height: height,
        width:  width,
      })
    end

    private

    attr_reader :interface

    def height
      interface.height
    end

    def width
      interface.width
    end

  end # ContentArea

end # Vedeu
