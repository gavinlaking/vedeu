module Vedeu
  class Geometry
    include Virtus.model

    attribute :y,      Integer, default: 1
    attribute :x,      Integer, default: 1
    attribute :width,  Integer, default: Terminal.width
    attribute :height, Integer, default: Terminal.height

    def origin(index = 0)
      Position.set(virtual_y(index), virtual_x)
    end

    def virtual_x(index = 0)
      ((x..dx).to_a)[index]
    end

    def virtual_y(index = 0)
      ((y..dy).to_a)[index]
    end

    def dy
      clip_y? ? defaults[:height] : (y + height)
    end

    def dx
      clip_x? ? defaults[:width] : (x + width)
    end

    private

    def clip_y?
      ((y + height) > defaults[:height])
    end

    def clip_x?
      ((x + width) > defaults[:width])
    end

    def defaults
      {
        width:  Terminal.width,
        height: Terminal.height
      }
    end
  end
end
