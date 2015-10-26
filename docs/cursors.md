# @title Vedeu Cursors
# Vedeu Cursors

Each interface defined in Vedeu will have a separate cursor named,
conveniently after the interface itself.

- The cursor can moved left, right, up or down via events; whether
  visible or not.
- The cursor can be shown or hidden (independently of the interface).
- The cursor may not be drawn on the border of the interface if a
  border is defined and visible for any side of the interface.
- The cursor may not be drawn outside of the geometry of the
  interface, even if a border is not defined or is invisible for the
  interface.
- The cursor may not be drawn outside of the boundary of the visible
  terminal.
- The position of the cursor is remembered for each interface.
- The cursor determines that which is shown in the interface via its
  offset (this allows content to be larger than the interface size and
  therefore 'scrolling').
- The cursor can be refreshed independently of the interface meaning
  the content of the interface can change position if needed.


## Cursor Events

Note: 'name' is a Symbol unless mentioned otherwise, and can be
substituted for 'Vedeu.focus' to use the interface currently in focus.

### `:\_cursor_origin\_`
This event moves the cursor to the interface origin; the top left
corner of the named interface.

    Vedeu.trigger(:_cursor_origin_, name)
    Vedeu.trigger(:_cursor_reset_, name)

### `:\_cursor_position\_`
To ascertain the position of a cursor in a named interface, use the
following event (substituting 'name' for the interface name):

    Vedeu.trigger(:_cursor_position_, name)

If you want to know where the cursor is without knowing the interface
name, you can check which interface is in focus:

    Vedeu.trigger(:_cursor_position_, Vedeu.focus)

### `:\_cursor_reposition\_`
Moves the cursor to a relative position inside the interface.

    Vedeu.trigger(:_cursor_reposition_, name, y, x)

## Cursor Movement Events

Adjusts the position of the named cursor or view in the direction
specified. If 'name' is unknown, using 'Vedeu.focus' will use the
interface currently in focus.

### `:\_cursor_left\_`
Moves the cursor one character left, unless the left-most position
for the view or terminal is reached.

    Vedeu.trigger(:_cursor_left_, name)
    Vedeu.trigger(:_cursor_left_, Vedeu.focus)

### `:\_cursor_down\_`

    Vedeu.trigger(:_cursor_down_, name)
    Vedeu.trigger(:_cursor_down_, Vedeu.focus)

### `:\_cursor_up\_`
Moves the cursor one line up, unless the top-most position for the
view or terminal is reached.

    Vedeu.trigger(:_cursor_up_, name)
    Vedeu.trigger(:_cursor_up_, Vedeu.focus)

### `:\_cursor_right\_`

    Vedeu.trigger(:_cursor_right_, name)
    Vedeu.trigger(:_cursor_right_, Vedeu.focus)

### `:\_cursor_top\_`
Moves the cursor to the top-most position for the view or terminal.
If the view contains content, then this event will effectively scroll
to the first line of the content.

    Vedeu.trigger(:_cursor_top_, name)
    Vedeu.trigger(:_cursor_top_, Vedeu.focus)

### `:\_cursor_bottom\_`
Moves the cursor to the bottom-most position for the view or terminal.
If the view contains content, then this event will effectively scroll
to the last line of the content.

    Vedeu.trigger(:_cursor_bottom_, name)
    Vedeu.trigger(:_cursor_bottom_, Vedeu.focus)
