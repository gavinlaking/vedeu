module Vedeu

  # The grid system splits the terminal height and width into 12 equal parts, by
  # dividing the available height and width by 12. If the terminal height or
  # width is not a multiple of 12, then Grid chooses the maximum value which
  # will fit.
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
    # @example
    #  Vedeu.geometry 'main_interface' do
    #    width: columns(9) # Vedeu.width # => 92 (for example)
    #                      # 92 / 12 = 7
    #                      # 7 * 9 = 63
    #                      # Therefore, width is 63 characters.
    #
    # @raise [OutOfRange] When the value parameter is not between 1 and 12
    #   inclusive.
    # @return [Fixnum|OutOfRange]
    def columns
      fail OutOfRange,
           'Valid value between 1 and 12 inclusive.' if out_of_range?

      column * value
    end

    # Returns the height in characters for the number of rows specified.
    #
    # @example
    #  Vedeu.geometry 'main_interface' do
    #    height: rows(3) # Vedeu.height # => 38 (for example)
    #                    # 38 / 12 = 3
    #                    # 3 * 3 = 9
    #                    # Therefore, height is 9 characters.
    #
    # @raise [OutOfRange] When the value parameter is not between 1 and 12
    #   inclusive.
    # @return [Fixnum|OutOfRange]
    def rows
      fail OutOfRange,
           'Valid value between 1 and 12 inclusive.' if out_of_range?

      row * value
    end

    protected

    # @!attribute [r] value
    # @return [Fixnum]
    attr_reader :value

    private

    # Returns the height of a single row in characters.
    #
    # @return [Fixnum]
    def row
      Vedeu.height / 12
    end

    # Returns a boolean indicating whether the value is out of range.
    #
    # @return [Boolean]
    def out_of_range?
      value < 1 || value > 12
    end

    # Returns the width of a single column in characters.
    #
    # @return [Fixnum]
    def column
      Vedeu.width / 12
    end

  end # Grid

end # Vedeu
