module Vedeu
  class Geometry
    def initialize(values = {})
      @values = values
    end

    def width
      values[:width]
    end

    def height
      values[:height]
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

    private

    def values
      defaults.merge!(@values)
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
