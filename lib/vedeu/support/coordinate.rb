require_relative 'esc'
require_relative 'terminal'

module Vedeu
  class OutOfBoundsError < StandardError; end

  class Coordinate
    def initialize(attrs = {})
      @attrs           = attrs
      @height          = attrs.fetch(:height)
      @width           = attrs.fetch(:width)
      @terminal_height = attrs.fetch(:terminal_height, Terminal.height)
      @terminal_width  = attrs.fetch(:terminal_width,  Terminal.width)
      @y               = attrs.fetch(:y, 1)
      @x               = attrs.fetch(:x, 1)
      @centred         = attrs.fetch(:centred, true)
    end

    def origin(index = 0)
      Esc.set_position(virtual_y(index), virtual_x)
    end

    def terminal_height
      fail_if_less_than_one(@terminal_height)

      fail_if_out_of_bounds('terminal_height',
                            @terminal_height,
                            Terminal.height)

      @terminal_height
    end

    def height
      fail_if_less_than_one(@height)

      fail_if_out_of_bounds('height', @height, terminal_height)

      @height
    end

    def y
      fail_if_less_than_one(@y)

      fail_if_out_of_bounds('y', @y, terminal_height)

      @y
    end

    def terminal_width
      fail_if_less_than_one(@terminal_width)

      fail_if_out_of_bounds('terminal_width',
                            @terminal_width,
                            Terminal.width)

      @terminal_width
    end

    def width
      fail_if_less_than_one(@width)

      fail_if_out_of_bounds('width', @width, terminal_width)

      @width
    end

    def x
      fail_if_less_than_one(@x)

      fail_if_out_of_bounds('x', @x, terminal_width)

      @x
    end

    def centred
      !!(@centred)
    end

    def centre
      [(terminal_height / 2), (terminal_width / 2)]
    end

    def centre_y
      centre.first
    end

    def centre_x
      centre.last
    end

    def top
      if centred
        centre_y - (height / 2)
      else
        y
      end
    end

    def left
      if centred
        centre_x - (width / 2)
      else
        x
      end
    end

    def bottom
      top + height
    end

    def right
      left + width
    end

    def position
      {
        y:       top,
        x:       left,
        height:  height,
        width:   width,
        centred: centred,
        top:     top,
        bottom:  bottom,
        left:    left,
        right:   right,
      }
    end

    private

    def fail_if_less_than_one(value)
      fail OutOfBoundsError,
        'Value must be greater than or equal to 1.' if value < 1
    end

    def fail_if_out_of_bounds(name, attribute, boundary)
      if attribute > boundary
        fail OutOfBoundsError,
          "Cannot set #{name} to be outside the terminal visible area."
      end
    end

    def virtual_x
      left
    end

    def virtual_y(index = 0)
      ((top..bottom).to_a)[index]
    end

  end
end
