### `:_cursor_top_`

Moves the cursor to the top-most position for the view or terminal.
If the view contains content, then this event will effectively scroll
to the first line of the content.

    Vedeu.trigger(:_cursor_top_, name)
    Vedeu.trigger(:_cursor_top_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
