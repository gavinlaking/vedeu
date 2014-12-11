# Monkey-patch Ruby's Fixnum to provide a columns method.
# @todo Don't monkey-patch because it is naughty.
class Fixnum

  # Augment Fixnum to calculate column width in a grid-based layout.
  #
  # The grid system splits the terminal width into 12 equal parts, by dividing
  # the available width by 12. If the terminal width is not a multiple of 12,
  # then Grid chooses the maximum value which will fit.
  #
  # Used primarily at interface creation time:
  #
  #   width: 9.columns  # (Terminal width / 12) * 9 characters wide; e.g.
  #                     # Terminal is 92 characters wide, maximum value is
  #                     # therefore 84, meaning a column is 7 characters wide.
  def columns
    Vedeu::Grid.columns(self)
  end

end # Fixnum

module Vedeu

  # Divides horizontal terminal space into 12 equal columns, discarding
  # the remainder.
  #
  # @api private
  class Grid

    # @param value [Fixnum]
    # @return [Fixnum]
    def self.columns(value)
      new(value).columns
    end

    # @param value [Fixnum]
    # @return [Grid]
    def initialize(value)
      @value = value
    end

    # @raise [OutOfRange] When the value parameter is not between 1 and 12
    #   inclusive.
    # @return [Fixnum|OutOfRange]
    def columns
      fail OutOfRange,
        'Valid value between 1 and 12 inclusive.' if out_of_range?

      column * value
    end

    private

    attr_reader :value

    # Returns the width of a single column in characters.
    #
    # @return [Fixnum]
    def column
      actual / 12
    end

    # @return [Fixnum]
    def actual
      Terminal.width
    end

    # @return [Boolean]
    def out_of_range?
      value < 1 || value > 12
    end

  end # Grid

  class ConsoleGeometry

    # Returns an instance of ConsoleGeometry.
    #
    # @param height [Fixnum]
    # @param width [Fixnum]
    # @return [ConsoleGeometry]
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
      if offset >= (height - 1)
        height

      elsif offset <= 1
        1

      else
        1 + offset

      end
    end

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
      if offset >= (height - 1)
        1

      elsif offset < 0
        height

      else
        height - offset

      end
    end

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
      if offset >= (width - 1)
        width

      elsif offset <= 1
        1

      else
        1 + offset

      end
    end

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
      if offset >= (width - 1)
        1

      elsif offset < 0
        width

      else
        width - offset

      end
    end

    private

    attr_reader :height, :width
  end

end # Vedeu
