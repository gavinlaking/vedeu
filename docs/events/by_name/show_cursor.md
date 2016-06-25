### Vedeu.show_cursor / `:_show_cursor_`

Show a named cursor, or without a name, the cursor of the currently
focussed interface.

    Vedeu.trigger(:_show_cursor_, name)
    Vedeu.trigger(:_show_cursor_, Vedeu.focus)
    Vedeu.trigger(:_show_cursor_)

    Vedeu.trigger(:_cursor_show_, name)
    Vedeu.trigger(:_cursor_show_, Vedeu.focus)
    Vedeu.trigger(:_cursor_show_)

    Vedeu.show_cursor(name)
    Vedeu.show_cursor(Vedeu.focus)
    Vedeu.show_cursor
