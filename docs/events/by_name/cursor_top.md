### `:_cursor_top_`
Moves the cursor to the top-most position for the view or terminal.
If the view contains content, then this event will effectively scroll
to the first line of the content.

    Vedeu.trigger(:_cursor_top_, name)
    Vedeu.trigger(:_cursor_top_, Vedeu.focus)
