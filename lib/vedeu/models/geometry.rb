module Vedeu

  # Calculates and provides interface geometry determined by both the client's
  # requirements and the terminal's current viewing area.
  #
  # Geometry for Vedeu, as the same for ANSI terminals, has the origin at
  # top-left, y = 1, x = 1. The 'y' coordinate is deliberately first.
  #
  # @api private
  class Geometry

    attr_reader :attributes, :centred, :height, :width

    # Returns a new instance of Geometry.
    #
    # @param attributes [Hash]
    # @return [Geometry]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @centred = @attributes[:centred]
      @height  = @attributes[:height]
      @width   = @attributes[:width]
    end

    # Returns the row/line position for the interface.
    #
    # @return [Fixnum]
    def y
      if attributes[:y].is_a?(Proc)
        attributes[:y].call

      else
        attributes[:y]

      end
    end

    # Returns the column position for the interface.
    #
    # @return [Fixnum]
    def x
      if attributes[:x].is_a?(Proc)
        attributes[:x].call

      else
        attributes[:x]

      end
    end

    # Returns a dynamic value calculated from the current terminal width,
    # combined with the desired column start point.
    #
    # If the interface is `centred` then if the terminal resizes, this value
    # should attempt to accommodate that.
    #
    # For uncentred interfaces, when the terminal resizes, then this will help
    # Vedeu render the view to ensure no row/line overruns or that the content
    # is not off-screen.
    #
    # @return [Fixnum]
    def viewport_width
      if (x + width) > Terminal.width
        new_width = width - ((x + width) - Terminal.width)
        return new_width < 1 ? 1 : new_width

      else
        width

      end
    end

    # Returns a dynamic value calculated from the current terminal height,
    # combined with the desired row start point.
    #
    # If the interface is `centred` then if the terminal resizes, this value
    # should attempt to accommodate that.
    #
    # For uncentred interfaces, when the terminal resizes, then this will help
    # Vedeu render the view to ensure the content is not off-screen.
    #
    # @return [Fixnum]
    def viewport_height
      if (y + height) > Terminal.height
        new_height = height - ((y + height) - Terminal.height)
        return new_height < 1 ? 1 : new_height

      else
        height

      end
    end

    # Returns the top-left coordinate, relative to the interface's position.
    #
    # @param index [Fixnum]
    # @param block [Proc]
    # @return [String]
    def origin(index = 0, &block)
      Esc.set_position(virtual_y[index], left, &block)
    end

    # Returns the top coordinate of the interface, a fixed or dynamic value
    # depending on whether the interface is centred or not.
    #
    # @return [Fixnum]
    def top
      if centred
        Terminal.centre_y - (viewport_height / 2)

      else
        y

      end
    end

    # Returns the row above the top by default.
    #
    # @example
    #   `top` is 4.
    #
    #   north     # => 3
    #   north(2)  # => 2
    #   north(-4) # => 8
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def north(value = 1)
      top - value
    end

    # Returns the left coordinate of the interface, a fixed or dynamic value
    # depending on whether the interface is centred or not.
    #
    # @return [Fixnum]
    def left
      if centred
        Terminal.centre_x - (viewport_width / 2)

      else
        x

      end
    end

    # Returns the column before left by default.
    #
    # @example
    #   `left` is 8.
    #
    #   west      # => 7
    #   west(2)   # => 6
    #   west(-4)  # => 12
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def west(value = 1)
      left - value
    end

    # Returns the bottom coordinate of the interface, a fixed or dynamic value
    # depending on the value of {#top}.
    #
    # @todo I think `height` should be `viewport_height` because the terminal
    #   may have resized, and viewport_height will properly handle this.
    #
    # @return [Fixnum]
    def bottom
      top + viewport_height
    end

    # Returns the row below the bottom by default.
    #
    # @example
    #   `bottom` is 12.
    #
    #   south     # => 13
    #   south(2)  # => 14
    #   south(-4) # => 8
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def south(value = 1)
      bottom + value
    end

    # Returns the right coordinate of the interface, a fixed or dynamic value
    # depending on the value of {#left}.
    #
    # @todo I think `width` should be `viewport_width` because the terminal may
    #   have resized, and viewport_width will properly handle this.
    #
    # @return [Fixnum]
    def right
      left + viewport_width
    end

    # Returns the column after right by default.
    #
    # @example
    #   `right` is 19.
    #
    #   east     # => 20
    #   east(2)  # => 21
    #   east(-4) # => 15
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def east(value = 1)
      right + value
    end

    # Provides a virtual y position within the interface's dimensions.
    #
    # @example
    #   # top = 3
    #   # bottom = 6
    #   # virtual_y # => [3, 4, 5]
    #
    # @return [Array]
    def virtual_y
      (top...bottom).to_a
    end

    # Provides a virtual x position within the interface's dimensions.
    #
    # @example
    #   # left = 9
    #   # right = 13
    #   # virtual_x # => [9, 10, 11, 12]
    #
    # @return [Array]
    def virtual_x
      (left...right).to_a
    end

    # Provides all the geometry in a convenient hash.
    #
    # @return [Hash]
    def to_h
      {
        centred:         centred,
        height:          height,
        width:           width,
        x:               x,
        y:               y,
        viewport_height: viewport_height,
        viewport_width:  viewport_width,
        top:             top,
        right:           right,
        bottom:          bottom,
        left:            left,
        north:           north,
        east:            east,
        south:           south,
        west:            west,
        virtual_x:       virtual_x,
        virtual_y:       virtual_y,
      }
    end

    private

    # The default geometry of an interface- full screen.
    #
    # @return [Hash]
    def defaults
      {
        y:       1,
        x:       1,
        width:   Terminal.width,
        height:  Terminal.height,
        centred: false,
      }
    end

  end # Geometry

end # Vedeu
