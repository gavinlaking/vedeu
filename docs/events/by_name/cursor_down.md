### `:_cursor_down_`

Moves the cursor one line down, unless the bottom-most position for
the view or terminal is reached.

    Vedeu.trigger(:_cursor_down_, name)
    Vedeu.trigger(:_cursor_down_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
