# @title Vedeu Movement Events

## Movement Events

Note: 'name' is a Symbol unless mentioned otherwise.

### :\_cursor_origin_
This event moves the cursor to the interface origin; the top left
corner of the named interface.

    Vedeu.trigger(:_cursor_origin_, name)
    Vedeu.trigger(:_cursor_reset_, name)

### :\_cursor_position_
See {file:docs/cursor.md#Where_is_the_cursor_}

### :\_cursor_reposition_
Moves the cursor to a relative position inside the interface.

    Vedeu.trigger(:_cursor_reposition_, name, y, x)

### :\_cursor_(up, down, left, right)_
Adjusts the position of the cursor or view.

With a given name, the cursor belonging to that interface will move
in the direction specified. If you do not know the name at that time,
you can use 'Vedeu.focus' to indicate the interface currently in
focus.

    Vedeu.trigger(:_cursor_left_, name)
    Vedeu.trigger(:_cursor_left_, Vedeu.focus)

    Vedeu.trigger(:_cursor_right_)
    Vedeu.trigger(:_cursor_up_)
    Vedeu.trigger(:_cursor_down_)

- The cursor or view may not be visible, but it will still move if
  requested.
- The cursor will not exceed the border or boundary of the interface,
  or boundary of the visible terminal.
- The cursor will move freely within the bounds of the interface,
  irrespective of content.
- The view will not exceed the boundary of the visible terminal,
  though its offset may (this means content will appear to have
  scrolled).
- The view will move freely within the bounds of the interface,
  irrespective of content.

### :\_view_(up, down, left, right)_

See {file:docs/events.md#\_cursor__up_down_left_right_}

Please note that the name of the view is required for these events.

    Vedeu.trigger(:_view_down_, name)
    Vedeu.trigger(:_view_left_, name)
    Vedeu.trigger(:_view_right_, name)
    Vedeu.trigger(:_view_up_, name)

Each of the :\_view_* events has an alias, :\_geometry_* if you prefer.
