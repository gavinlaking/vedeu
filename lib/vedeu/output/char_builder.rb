module Vedeu

  # Included in {Vedeu::Clear} and {Vedeu::Output}, this module builds
  # {Vedeu::Char} objects.
  #
  module CharBuilder

    # Builds a new Vedeu::Char object.
    #
    # @param value [String]
    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Char]
    def char_builder(value, iy, ix)
      Vedeu::Char.new({ value:    value,
                        colour:   interface.colour,
                        style:    interface.style,
                        position: origin(iy, ix) })
    end

    # Returns the position of the cursor at the top-left coordinate, relative to
    # the interface's position.
    #
    # @param y_index [Fixnum]
    # @param x_index [Fixnum]
    # @return [Vedeu::Position]
    def origin(y_index = 0, x_index = 0)
      Vedeu::IndexPosition.new(y_index,
                               x_index,
                               interface.top,
                               interface.left).to_position
    end

  end # CharBuilder

end # Vedeu
