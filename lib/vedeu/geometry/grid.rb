module Vedeu

  # Augment Fixnum to calculate column width or row height in a grid-based
  # layout.
  #
  # The grid system splits the terminal height and width into 12 equal parts, by
  # dividing the available height and width by 12. If the terminal height or
  # width is not a multiple of 12, then Grid chooses the maximum value which
  # will fit.
  #
  # Used primarily whilst defining geometry:
  #
  #   width: columns(9) # (Terminal width / 12) * 9 characters wide; e.g.
  #                     # Terminal is 92 characters wide, maximum value is
  #                     # therefore 84, meaning a column is 7 characters wide.
  #                     # (And width is therefore 63 characters wide.)
  #
  #   height: rows(3)   # (Terminal height / 12) * 3 rows high; e.g.
  #                     # Terminal is 38 characters wide, maximum value is
  #                     # therefore 36, meaning a row is 3 characters tall.
  #                     # (And height is therefore 9 characters tall.)
  #
  # @api public
  class Grid

    # @see #initialize
    # @see #columns
    def self.columns(value)
      new(value).columns
    end

    # @see #initialize
    # @see #rows
    def self.rows(value)
      new(value).rows
    end

    # Returns a new instance of Vedeu::Grid.
    #
    # @param value [Fixnum]
    # @return [Grid]
    def initialize(value)
      @value = value
    end

    # Returns the width in characters for the number of columns specified.
    #
    # @raise [OutOfRange] When the value parameter is not between 1 and 12
    #   inclusive.
    # @return [Fixnum|OutOfRange]
    def columns
      fail OutOfRange,
           'Valid value between 1 and 12 inclusive.' if out_of_range?

      column * value
    end

    # Returns the height of a single row in characters.
    #
    # @return [Fixnum]
    def height
      actual_height / 12
    end
    alias_method :row, :height

    # Returns the height in characters for the number of rows specified.
    #
    # @raise [OutOfRange] When the value parameter is not between 1 and 12
    #   inclusive.
    # @return [Fixnum|OutOfRange]
    def rows
      fail OutOfRange,
           'Valid value between 1 and 12 inclusive.' if out_of_range?

      row * value
    end

    # Returns the width of a single column in characters.
    #
    # @return [Fixnum]
    def width
      actual_width / 12
    end
    alias_method :column, :width

    protected

    # @!attribute [r] value
    # @return [Fixnum]
    attr_reader :value

    private

    # @return [Fixnum]
    def actual_height
      Vedeu::Terminal.height
    end

    # @return [Fixnum]
    def actual_width
      Vedeu::Terminal.width
    end

    # @return [Boolean]
    def out_of_range?
      value < 1 || value > 12
    end

  end # Grid

end # Vedeu
