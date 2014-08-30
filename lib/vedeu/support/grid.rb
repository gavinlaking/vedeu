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
end

module Vedeu
  class Grid

    # @param value [Fixnum]
    # @return []
    def self.columns(value)
      new(value).columns
    end

    # @param value [Fixnum]
    # @return [Grid]
    def initialize(value)
      @value = value
    end

    # @return []
    def columns
      fail OutOfRange, 'Valid range is 1..12.' if out_of_range?

      column * value
    end

    private

    attr_reader :value

    # @api private
    # @return [Fixnum]
    def column
      actual / 12
    end

    # @api private
    # @return [Fixnum]
    def actual
      Terminal.width
    end

    # @api private
    # @return [TrueClass|FalseClass]
    def out_of_range?
      value < 1 || value > 12
    end

  end
end
