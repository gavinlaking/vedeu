### `:_cursor_origin_`

This event moves the cursor to the interface origin; the top left
corner of the named interface.

    Vedeu.trigger(:_cursor_origin_, name)
    Vedeu.trigger(:_cursor_origin_, Vedeu.focus)

    Vedeu.trigger(:_cursor_reset_, name)
    Vedeu.trigger(:_cursor_reset_, Vedeu.focus)
