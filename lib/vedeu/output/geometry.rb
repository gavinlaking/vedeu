module Vedeu
  class Geometry
    def initialize(values = {})
      @values = values || {}
    end

    def origin(index = 0)
      Position.set(vy(index), vx)
    end

    def y
      values[:y]
    end
    alias_method :row,  :y
    alias_method :line, :y

    def x
      values[:x]
    end
    alias_method :column, :x
    alias_method :col,    :x

    def width
      values[:width]
    end

    def height
      values[:height]
    end

    def dy
      clip_y? ? defaults[:height] : (y + height)
    end

    def dx
      clip_x? ? defaults[:width] : (x + width)
    end

    def vx(index = 0) # virtual x position
      ((x..dx).to_a)[index]
    end

    def vy(index = 0) # virtual y position
      ((y..dy).to_a)[index]
    end

    private

    def clip_y?
      ((y + height) > defaults[:height])
    end

    def clip_x?
      ((x + width) > defaults[:width])
    end

    def values
      defaults.merge!(auto)
    end

    def auto
      @values.delete_if { |k, v| k == :width  && v == :auto }
      @values.delete_if { |k, v| k == :height && v == :auto }
    end

    def defaults
      {
        width:  Terminal.width,
        height: Terminal.height,
        y:      1,
        x:      1
      }
    end
  end
end
