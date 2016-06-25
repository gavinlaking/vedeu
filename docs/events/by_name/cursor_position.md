### `:_cursor_position_`

To ascertain the position of a cursor in a named interface, use the
following event (substituting 'name' for the interface name):

    Vedeu.trigger(:_cursor_position_, name)

If you want to know where the cursor is without knowing the interface
name, you can check which interface is in focus:

    Vedeu.trigger(:_cursor_position_, Vedeu.focus)
