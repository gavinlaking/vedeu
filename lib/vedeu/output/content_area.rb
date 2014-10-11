module Vedeu

  # Returns the geometry for content in the interface.
  #
  class ContentArea

    # Return an instance of ContentArea
    #
    # @param interface [Interface]
    # @return [ContentArea]
    def initialize(interface)
      @interface = interface
    end

    # Return an Area representing the geometry of this content.
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
      if content?
        [interface.lines.size, interface.height].max

      else
        interface.height

      end
    end

    def width
      if content?
        [maximum_line_length, interface.width].max

      else
        interface.width

      end
    end

    def maximum_line_length
      interface.lines.map do |line|
        line.streams.map(&:content).join.size
      end.max
    end

    def content?
      interface.lines.any?
    end

  end # ContentArea

end # Vedeu
