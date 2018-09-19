# @title Vedeu Geometry
# Vedeu Geometry

Geometry defines the shape of an interface or view. It determines
where an interface or view will display within the terminal space.
Terminal geometry starts at position (1, 1), which is the top left
of the terminal.

- It has a name. This name associates it with an
  {file:docs/interfaces.md Interface}.
- It has dimensions- a width and a height.
  - The 'width' is the number of characters wide, and is defined as
    being ('xn' - 'x') or ('x' + 'width').
  - The 'height' is the number of lines tall, and is defined as
    being ('yn' - 'y') or ('y' + 'height').
  - 'x' refers to the starting coordinate of the horizontal axis.
  - 'y' refers to the starting coordinate of the vertical axis.
  - 'xn' refers to the ending coordinate of the horizontal axis.
  - 'yn' refers to the ending coordinate of the vertical axis.
  - Using 'xn' and 'yn' is optional, as is 'width' and 'height'. In
    their absence, Vedeu will extend the width from 'x' to the right
    edge of the terminal, likewise the height from the 'y' to the
    bottom edge of the terminal.
- Geometry can be maximised- to use all the available terminal space.
- It can also be unmaximised- to return to the pre-defined dimensions
  as mentioned above.
- Geometry can be aligned; either left, centre or right. When defined
  in this way, the 'x', 'xn', 'y' and 'yn' parameters will be
  calculated automatically.
- Geometry like a {file:docs/cursors.md Cursor}, via events can be
  moved; left, right, up or down.
