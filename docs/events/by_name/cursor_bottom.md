### `:_cursor_bottom_`

Moves the cursor to the bottom-most position for the view or terminal.
If the view contains content, then this event will effectively scroll
to the last line of the content.

    Vedeu.trigger(:_cursor_bottom_, name)
    Vedeu.trigger(:_cursor_bottom_, Vedeu.focus)
