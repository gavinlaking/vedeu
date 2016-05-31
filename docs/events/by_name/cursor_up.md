### `:_cursor_up_`

Moves the cursor one line up, unless the top-most position for the
view or terminal is reached.

    Vedeu.trigger(:_cursor_up_, name)
    Vedeu.trigger(:_cursor_up_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
