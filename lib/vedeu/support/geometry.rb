require_relative 'esc'
require_relative 'terminal'

module Vedeu
  class Geometry
    def self.origin(interface, index = 0)
      new(interface, index).origin
    end

    def initialize(interface, index = 0)
      @interface, @index = interface, index
    end

    def origin
      Esc.set_position(virtual_y(index), virtual_x)
    end

    def virtual_x(index = 0)
      ((x..max_x).to_a)[index]
    end

    def virtual_y(index = 0)
      ((y..max_y).to_a)[index]
    end

    def max_y
      if ((y + height) > screen_height)
        screen_height

      else
        (y + height)

      end
    end

    def max_x
      if ((x + width) > screen_width)
        screen_width

      else
        (x + width)

      end
    end

    private

    attr_reader :interface, :index

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

    def screen_height
      @height ||= Terminal.height
    end

    def screen_width
      @width ||= Terminal.width
    end
  end
end
