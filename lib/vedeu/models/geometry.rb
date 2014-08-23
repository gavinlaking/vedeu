module Vedeu
  class Geometry
    def initialize(attributes = {})
      @attributes = attributes
    end

    def attributes
      defaults.merge!(@attributes)
    end

    def y
      if attributes[:y].is_a?(Proc)
        attributes[:y].call

      else
        attributes[:y]

      end
    end

    def x
      if attributes[:x].is_a?(Proc)
        attributes[:x].call

      else
        attributes[:x]

      end
    end

    def width
      @width ||= attributes[:width]
    end

    def height
      @height ||= attributes[:height]
    end

    def centred
      @centred ||= attributes[:centred]
    end

    def viewport_width
      if (x + width) > Terminal.width
        width - ((x + width) - Terminal.width)

      else
        width

      end
    end

    def viewport_height
      if (y + height) > Terminal.height
        height - ((y + height) - Terminal.height)

      else
        height

      end
    end

    def origin(index = 0, &block)
      Esc.set_position(virtual_y[index], left, &block)
    end

    def top
      if centred
        centre_y - (viewport_height / 2)

      else
        y

      end
    end

    def north(value = 1)
      top - value
    end

    def left
      if centred
        centre_x - (viewport_width / 2)

      else
        x

      end
    end

    def west(value = 1)
      left - value
    end

    def bottom
      top + height
    end

    def south(value = 1)
      bottom + value
    end

    def right
      left + width
    end

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
