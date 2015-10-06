# @title Vedeu Cursors
# Vedeu Cursors

Each interface defined in Vedeu will have a separate cursor named,
conveniently after the interface itself.

- The cursor can moved left, right, up or down via events.
- The cursor can be shown or hidden (independently of the interface).
- The cursor may not be drawn on the border of the interface if a
  border is defined and visible for any side of the interface.
- The cursor may not be drawn outside of the geometry of the interface
  if a border is not defined or is invisible for the interface.
- The position of the cursor is remembered for each interface.
- The cursor determines that which is shown in the interface via its
  offset (this allows content to be larger than the interface size and
  therefore 'scrolling').
- The cursor can be refreshed independently of the interface meaning
  the content of the interface can change position if needed.
