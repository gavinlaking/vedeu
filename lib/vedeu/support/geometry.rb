require_relative 'esc'
require_relative 'terminal'

module Vedeu
  class Geometry
    def initialize(interface)
      @interface = interface
    end

    def origin(index = 0)
      Esc.set_position(virtual_y(index), virtual_x)
    end

    private

    attr_reader :interface

    def virtual_x(index = 0)
      ((x..max_x).to_a)[index]
    end

    def virtual_y(index = 0)
      ((y..max_y).to_a)[index]
    end

    def max_y
      if ((y + height) > Terminal.height)
        Terminal.height

      else
        (y + height)

      end
    end

    def max_x
      if ((x + width) > Terminal.width)
        Terminal.width

      else
        (x + width)

      end
    end

    def height
      interface.height
    end

    def width
      interface.width
    end

    def x
      interface.x
    end

    def y
      interface.y
    end
  end
end
