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
The following `cursor` statements are equivalent:

    # Vedeu.interface :my_interface do
      cursor true
      cursor!
      show_cursor!

      # ...
    # end

#### Hiding the cursor
The following `cursor` statements are equivalent:

    # Vedeu.interface :my_interface do
      cursor false
      no_cursor!
      hide_cirsor!

      # ...
    # end

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


## Cursor Events

{include:file:docs/events/by_name/refresh_cursor.md}

## Cursor Positioning Events

{include:file:docs/events/by_name/cursor_origin.md}

{include:file:docs/events/by_name/cursor_position.md}

{include:file:docs/events/by_name/cursor_reposition.md}

## Cursor Movement Events

Adjusts the position of the named cursor or view in the direction
specified. If 'name' is unknown, using 'Vedeu.focus' will use the
interface currently in focus.

{include:file:docs/events/by_name/cursor_left.md}

{include:file:docs/events/by_name/cursor_down.md}

{include:file:docs/events/by_name/cursor_up.md}

{include:file:docs/events/by_name/cursor_right.md}

{include:file:docs/events/by_name/cursor_top.md}

{include:file:docs/events/by_name/cursor_bottom.md}

## Cursor Visibility API & Events

Change the visibility of the cursor via an event or API call. These
can be called at any time and affect the cursor of the named
interface, or when a name is not given, the interface currently in
focus.

{include:file:docs/events/by_name/hide_cursor.md}

{include:file:docs/events/by_name/show_cursor.md}

{include:file:docs/events/by_name/toggle_cursor.md}
