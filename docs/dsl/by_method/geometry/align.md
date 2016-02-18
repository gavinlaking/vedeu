Align the interface/view horizontally or vertically within the
terminal.

An error will be raised if:

- When the vertical argument is not given.
- When the horizontal argument is not given.
- When the horizontal argument is given (and not :none) and the width
  argument is not given.
- When the vertical argument is given (and not :none) and the height
  argument is not given.

Aligning the view with the bottom of the terminal:

    # Vedeu.geometry :my_interface do
        align vertical: :bottom

        # ...
    # end

Aligning the view in the centre (horizontally) of the terminal:

    # Vedeu.geometry :my_interface do
        align horizontal: :centre

        # ...
    # end

Aligning the view with the left of the terminal:

    # Vedeu.geometry :my_interface do
        align horizontal: :left

        # ...
    # end

Aligning the view in the middle (vertically) of the terminal:

    # Vedeu.geometry :my_interface do
        align vertical: :middle

        # ...
    # end

Aligning the view with the right of the terminal:

    # Vedeu.geometry :my_interface do
        align horizontal: :right

        # ...
    # end

Aligning the view with the top of the terminal:

    # Vedeu.geometry :my_interface do
        align vertical: :top

        # ...
    # end
