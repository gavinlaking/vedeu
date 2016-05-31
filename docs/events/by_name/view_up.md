### `:_view_up_`

Moves the view one row/line up, unless the top/first row/line for
the terminal is reached.

    Vedeu.trigger(:_view_up_, name)
    Vedeu.trigger(:_view_up_, Vedeu.focus)

    Vedeu.trigger(:_geometry_up_, name)
    Vedeu.trigger(:_geometry_up_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
