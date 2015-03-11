module Vedeu

  # Provides coordinates based on the height and width provided.
  # Coordinates always start from 1, 1.
  #
  class BoundingArea

    # @!attribute [r] height
    # @return [Fixnum]
    attr_reader :height

    # @!attribute [r] width
    # @return [Fixnum]
    attr_reader :width

    # Returns an instance of BoundingArea.
    #
    # @param height [Fixnum]
    # @param width [Fixnum]
    # @return [Vedeu::BoundingArea]
    def initialize(height, width)
      @height = height
      @width  = width
    end

    # Returns the top line (y) coordinate for the console.
    #
    # @example
    #   # height = 20
    #
    #   top     # => 1
    #   top(5)  # => 6
    #   top(-5) # => 1
    #   top(25) # => 20
    #
    # @param offset [Fixnum] When provided, returns the top coordinate plus
    #   the offset.
    # @return [Fixnum]
    def top(offset = 0)
      if offset >= height
        height

      elsif offset <= 1
        1

      else
        1 + offset

      end
    end
    alias_method :y, :top

    # Returns the bottom line (yn) coordinate for the console.
    #
    # @example
    #   # height = 20
    #
    #   bottom     # => 20
    #   bottom(5)  # => 15
    #   bottom(-5) # => 20
    #   bottom(25) # => 1
    #
    # @param offset [Fixnum] When provided, returns the bottom coordinate minus
    #   the offset.
    # @return [Fixnum]
    def bottom(offset = 0)
      if offset >= height
        1

      elsif offset < 0
        height

      else
        height - offset

      end
    end
    alias_method :yn, :bottom

    # Returns the leftmost column (x) coordinate for the console.
    #
    # @example
    #   # width = 40
    #
    #   left     # => 1
    #   left(5)  # => 6
    #   left(-5) # => 1
    #   left(45) # => 40
    #
    # @param offset [Fixnum] When provided, returns the left coordinate plus
    #   the offset.
    # @return [Fixnum]
    def left(offset = 0)
      if offset >= width
        width

      elsif offset <= 1
        1

      else
        1 + offset

      end
    end
    alias_method :x, :left

    # Returns the rightmost column (yn) coordinate for the console.
    #
    # @example
    #   # width = 40
    #
    #   right     # => 40
    #   right(5)  # => 35
    #   right(-5) # => 40
    #   right(45) # => 1
    #
    # @param offset [Fixnum] When provided, returns the right coordinate minus
    #   the offset.
    # @return [Fixnum]
    def right(offset = 0)
      if offset >= width
        1

      elsif offset < 0
        width

      else
        width - offset

      end
    end
    alias_method :xn, :right

  end # BoundingArea

end # Vedeu
