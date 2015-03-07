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

    # @!attribute [r] value
    # @return [Fixnum]
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

end # Vedeu
