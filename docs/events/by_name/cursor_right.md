### `:_cursor_right_`

Moves the cursor one character to the right, unless the right-most
position for the view or terminal is reached.

    Vedeu.trigger(:_cursor_right_, name)
    Vedeu.trigger(:_cursor_right_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
