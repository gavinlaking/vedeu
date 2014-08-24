module Vedeu
  class Geometry

    attr_reader :attributes, :centred, :height, :width

    # @param attributes [Hash]
    # @return [Geometry]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @centred = @attributes[:centred]
      @height  = @attributes[:height]
      @width   = @attributes[:width]
    end

    # @return [Fixnum]
    def y
      if attributes[:y].is_a?(Proc)
        attributes[:y].call

      else
        attributes[:y]

      end
    end

    # @return [Fixnum]
    def x
      if attributes[:x].is_a?(Proc)
        attributes[:x].call

      else
        attributes[:x]

      end
    end

    # @return [Fixnum]
    def viewport_width
      if (x + width) > Terminal.width
        width - ((x + width) - Terminal.width)

      else
        width

      end
    end

    # @return [Fixnum]
    def viewport_height
      if (y + height) > Terminal.height
        height - ((y + height) - Terminal.height)

      else
        height

      end
    end

    # @param index [Fixnum]
    # @param block [Proc]
    # @return [String]
    def origin(index = 0, &block)
      Esc.set_position(virtual_y[index], left, &block)
    end

    # @return [Fixnum]
    def top
      if centred
        centre_y - (viewport_height / 2)

      else
        y

      end
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def north(value = 1)
      top - value
    end

    # @return [Fixnum]
    def left
      if centred
        centre_x - (viewport_width / 2)

      else
        x

      end
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def west(value = 1)
      left - value
    end

    # @return [Fixnum]
    def bottom
      top + height
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def south(value = 1)
      bottom + value
    end

    # @return [Fixnum]
    def right
      left + width
    end

    # @param value [Fixnum]
    # @return [Fixnum]
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
