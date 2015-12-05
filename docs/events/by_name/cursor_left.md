### `:_cursor_left_`
Moves the cursor one character left, unless the left-most position
for the view or terminal is reached.

    Vedeu.trigger(:_cursor_left_, name)
    Vedeu.trigger(:_cursor_left_, Vedeu.focus)
