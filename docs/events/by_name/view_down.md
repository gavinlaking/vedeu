### `:_view_down_`

Moves the view one row/line down, unless the bottom/last row/line for
the terminal is reached.

    Vedeu.trigger(:_view_down_, name)
    Vedeu.trigger(:_view_down_, Vedeu.focus)

    Vedeu.trigger(:_geometry_down_, name)
    Vedeu.trigger(:_geometry_down_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
