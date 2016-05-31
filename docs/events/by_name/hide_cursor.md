### Vedeu.hide_cursor / `:_hide_cursor_`

Hide a named cursor, or without a name, the cursor of the currently
focussed interface.

    Vedeu.trigger(:_hide_cursor_, name)
    Vedeu.trigger(:_hide_cursor_, Vedeu.focus)
    Vedeu.trigger(:_hide_cursor_)

    Vedeu.trigger(:_cursor_hide_, name)
    Vedeu.trigger(:_cursor_hide_, Vedeu.focus)
    Vedeu.trigger(:_cursor_hide_)

    Vedeu.hide_cursor(name)
    Vedeu.hide_cursor(Vedeu.focus)
    Vedeu.hide_cursor
