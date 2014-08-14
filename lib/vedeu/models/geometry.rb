module Vedeu
  class Geometry
    def initialize(_attributes = {})
      @_attributes = _attributes
    end

    def attributes
      _attributes
    end

    def y
      @y ||= _attributes[:y]
    end

    def x
      @x ||= _attributes[:x]
    end

    def width
      @width ||= _attributes[:width]
    end

    def height
      @height ||= _attributes[:height]
    end

    def centred
      @centred ||= _attributes[:centred]
    end

    def origin(index = 0)
      Esc.set_position(virtual_y[index], left)
    end

    def top
      if centred
        centre_y - (height / 2)
      else
        y
      end
    end

    def north(value = 1)
      top - value
    end

    def left
      if centred
        centre_x - (width / 2)
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
      @_centre ||= Terminal.centre
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

    def _attributes
      defaults.merge!(@_attributes)
    end

    def defaults
      {
        y:       1,               # Integer, default: 1
        x:       1,               # Integer, default: 1
        width:   Terminal.width,  # Integer, default: Terminal.width
        height:  Terminal.height, # Integer, default: Terminal.height
        centred: false,           # Boolean, default: false
      }
    end
  end
end
