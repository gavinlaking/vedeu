### `:_cursor_left_`

Moves the cursor one character left, unless the left-most position
for the view or terminal is reached.

    Vedeu.trigger(:_cursor_left_, name)
    Vedeu.trigger(:_cursor_left_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
