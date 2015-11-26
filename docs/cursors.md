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


## Cursor API, DSL & Events

Note: 'name' is a Symbol unless mentioned otherwise, and can be
substituted for 'Vedeu.focus' to use the interface currently in focus.

Cursors are automatically created for each interface defined. You can
specify at the interface, or view level whether a cursor is shown or
hidden.

### Interface Cursors
The initial state of visible (true) or invisible (false) for a cursor
can be specified when defining the interface.

Each example within each interface definition is equivalent.

#### Showing the cursor

    Vedeu.interface :my_interface do
      cursor true

      # or...

      cursor!

      # ...
    end

#### Hiding the cursor

    Vedeu.interface :my_interface do
      cursor false

      # or...

      no_cursor!

      # ...
    end

### View Cursors
The view cursor is the same as the interface cursor with the same
name. However, view cursors can be made visible or invisible when the
view is rendered, overriding the initial or current state.

    Vedeu.views do
      view :my_interface do
        cursor true # => Specify the visibility of the cursor when
                    #    the view is rendered.

        # see other examples for other settings for cursor
      end
    end

    Vedeu.renders do
      view :my_interface do
        cursor false # => Specify the visibility of the cursor when
                     #    the view is rendered.

        # see other examples for other settings for cursor
      end
    end


## Cursor Positioning Events

### `:_cursor_origin_`
This event moves the cursor to the interface origin; the top left
corner of the named interface.

    Vedeu.trigger(:_cursor_origin_, name)
    Vedeu.trigger(:_cursor_reset_, name)

### `:_cursor_position_`
To ascertain the position of a cursor in a named interface, use the
following event (substituting 'name' for the interface name):

    Vedeu.trigger(:_cursor_position_, name)

If you want to know where the cursor is without knowing the interface
name, you can check which interface is in focus:

    Vedeu.trigger(:_cursor_position_, Vedeu.focus)

### `:_cursor_reposition_`
Moves the cursor to a relative position inside the interface.

    Vedeu.trigger(:_cursor_reposition_, name, y, x)

## Cursor Movement Events

Adjusts the position of the named cursor or view in the direction
specified. If 'name' is unknown, using 'Vedeu.focus' will use the
interface currently in focus.

### `:_cursor_left_`
Moves the cursor one character left, unless the left-most position
for the view or terminal is reached.

    Vedeu.trigger(:_cursor_left_, name)
    Vedeu.trigger(:_cursor_left_, Vedeu.focus)

### `:_cursor_down_`

    Vedeu.trigger(:_cursor_down_, name)
    Vedeu.trigger(:_cursor_down_, Vedeu.focus)

### `:_cursor_up_`
Moves the cursor one line up, unless the top-most position for the
view or terminal is reached.

    Vedeu.trigger(:_cursor_up_, name)
    Vedeu.trigger(:_cursor_up_, Vedeu.focus)

### `:_cursor_right_`

    Vedeu.trigger(:_cursor_right_, name)
    Vedeu.trigger(:_cursor_right_, Vedeu.focus)

### `:_cursor_top_`
Moves the cursor to the top-most position for the view or terminal.
If the view contains content, then this event will effectively scroll
to the first line of the content.

    Vedeu.trigger(:_cursor_top_, name)
    Vedeu.trigger(:_cursor_top_, Vedeu.focus)

### `:_cursor_bottom_`
Moves the cursor to the bottom-most position for the view or terminal.
If the view contains content, then this event will effectively scroll
to the last line of the content.

    Vedeu.trigger(:_cursor_bottom_, name)
    Vedeu.trigger(:_cursor_bottom_, Vedeu.focus)

## Cursor Visibility API & Events

Change the visibility of the cursor via an event or API call. These
can be called at any time and affect the cursor of the named
interface, or when a name is not given, the interface currently in
focus.

### Vedeu.hide_cursor / `:_cursor_hide_`
Hide the cursor.

    Vedeu.trigger(:_hide_cursor_, name)
    Vedeu.trigger(:_hide_cursor_, Vedeu.focus)
    Vedeu.trigger(:_cursor_hide_, name)
    Vedeu.trigger(:_cursor_hide_, Vedeu.focus)

    Vedeu.hide_cursor(name)
    Vedeu.hide_cursor(Vedeu.focus)

### Vedeu.show_cursor / `:_show_cursor_`
Show the cursor.

    Vedeu.trigger(:_show_cursor_, name)
    Vedeu.trigger(:_show_cursor_, Vedeu.focus)
    Vedeu.trigger(:_cursor_show_, name)
    Vedeu.trigger(:_cursor_show_, Vedeu.focus)

    Vedeu.show_cursor(name)
    Vedeu.show_cursor(Vedeu.focus)

### Vedeu.toggle_cursor / `:_toggle_cursor_`
Toggle the visibility of the cursor. If hidden, then show. If shown,
then hide.

    Vedeu.trigger(:_toggle_cursor_, name)
    Vedeu.trigger(:_toggle_cursor_, Vedeu.focus)

    Vedeu.toggle_cursor(name)
    Vedeu.toggle_cursor(Vedeu.focus)
