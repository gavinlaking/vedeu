module Vedeu
  class Geometry

    # @param  []
    # @return []
    def initialize(attributes = {})
      @attributes = attributes
    end

    # @return []
    def attributes
      defaults.merge!(@attributes)
    end

    # @return []
    def y
      if attributes[:y].is_a?(Proc)
        attributes[:y].call

      else
        attributes[:y]

      end
    end

    # @return []
    def x
      if attributes[:x].is_a?(Proc)
        attributes[:x].call

      else
        attributes[:x]

      end
    end

    # @return []
    def width
      @width ||= attributes[:width]
    end

    # @return []
    def height
      @height ||= attributes[:height]
    end

    # @return []
    def centred
      @centred ||= attributes[:centred]
    end

    # @return []
    def viewport_width
      if (x + width) > Terminal.width
        width - ((x + width) - Terminal.width)

      else
        width

      end
    end

    # @return []
    def viewport_height
      if (y + height) > Terminal.height
        height - ((y + height) - Terminal.height)

      else
        height

      end
    end

    # @param []
    # @param []
    # @return []
    def origin(index = 0, &block)
      Esc.set_position(virtual_y[index], left, &block)
    end

    # @return []
    def top
      if centred
        centre_y - (viewport_height / 2)

      else
        y

      end
    end

    # @param []
    # @return []
    def north(value = 1)
      top - value
    end

    # @return []
    def left
      if centred
        centre_x - (viewport_width / 2)

      else
        x

      end
    end

    # @param []
    # @return []
    def west(value = 1)
      left - value
    end

    # @return []
    def bottom
      top + height
    end

    # @param []
    # @return []
    def south(value = 1)
      bottom + value
    end

    # @return []
    def right
      left + width
    end

    # @param []
    # @return []
    def east(value = 1)
      right + value
    end

    private

    def centre
      Terminal.centre
    end

    def centre_y
      centre.first
    end

    def centre_x
      centre.last
    end

    def virtual_y
      @_virtual_y ||= (top..bottom).to_a
    end

    def defaults
      {
        y:       1,
        x:       1,
        width:   Terminal.width,
        height:  Terminal.height,
        centred: false,
      }
    end

  end
end
