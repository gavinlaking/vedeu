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


## Where is the cursor?

To ascertain the position of a cursor in a named interface, use the
following event (substituting 'name' for the interface name):

    Vedeu.trigger(:_cursor_position_, name)

If you want to know where the cursor is without knowing the interface
name, you can check which interface is in focus:

    Vedeu.trigger(:_cursor_position_, Vedeu.focus)


## Moving the cursor

See {file:docs/events/movement.md#__cursor__up__down__left__right__}
