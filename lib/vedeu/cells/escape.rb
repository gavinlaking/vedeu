module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # with a custom value, colour and style.
    #
    # The Vedeu::Cells::Escape object represents an escape sequence as
    # a single character, meaning they will behave dependent on the
    # context in which they are used.
    #
    # (In a terminal, an escape sequence makes sense, when a view is
    # being rendered as HTML, the sequence may be meaningless, for
    # example; the sequence to show or hide the cursor.)
    #
    # @api private
    #
    class Escape < Vedeu::Cells::Empty

    end # Escape

  end # Cells

end # Vedeu
