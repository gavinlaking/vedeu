### `:_view_right_`

Moves the view one row/line right, unless the right-most row/line for
the terminal is reached.

    Vedeu.trigger(:_view_right_, name)
    Vedeu.trigger(:_view_right_, Vedeu.focus)

    Vedeu.trigger(:_geometry_right_, name)
    Vedeu.trigger(:_geometry_right_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
