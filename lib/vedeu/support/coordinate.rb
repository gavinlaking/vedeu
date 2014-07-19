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
      fail OutOfBoundsError,
        'Value must be greater than or equal to 1.' if @terminal_height < 1

      if @terminal_height > Terminal.height
        fail OutOfBoundsError, 'Cannot set terminal_height to be ' \
                               'greater than the actual terminal ' \
                               'height.'
      else
        @terminal_height
      end
    end

    def height
      fail OutOfBoundsError,
        'Value must be greater than or equal to 1.' if @height < 1

      if @height > terminal_height
        fail OutOfBoundsError, 'Cannot set height to be greater ' \
                               'than the specified or actual '    \
                               'terminal height.'
      else
        @height
      end
    end

    def y
      fail OutOfBoundsError,
        'Value must be greater than or equal to 1.' if @y < 1

      if @y > terminal_height
        fail OutOfBoundsError, 'Cannot set y position to be greater' \
                               ' that the specified terminal height' \
                               ' or actual terminal height.'
      else
        @y
      end
    end

    def terminal_width
      fail OutOfBoundsError,
        'Value must be greater than or equal to 1.' if @terminal_width < 1
      if @terminal_width > Terminal.width
        fail OutOfBoundsError, 'Cannot set terminal_width to be '  \
                               'greater than the actual terminal ' \
                               'width.'
      else
        @terminal_width
      end
    end

    def width
      fail OutOfBoundsError,
        'Value must be greater than or equal to 1.' if @width < 1

      if @width > terminal_width
        fail OutOfBoundsError, 'Cannot set width to be greater ' \
                               'than the specified or actual ' \
                               'terminal width.'
      else
        @width
      end
    end

    def x
      fail OutOfBoundsError,
        'Value must be greater than or equal to 1.' if @x < 1

      if @x > terminal_width
        fail OutOfBoundsError, 'Cannot set x position to be greater' \
                               ' that the specified terminal width' \
                               ' or actual terminal width.'
      else
        @x
      end
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
        bottom:  bottom,
        right:   right,
      }
    end

    private

    def virtual_x
      left
    end

    def virtual_y(index = 0)
      ((top..bottom).to_a)[index]
    end

  end
end
