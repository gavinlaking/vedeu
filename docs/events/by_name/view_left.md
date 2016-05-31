### `:_view_left_`

Moves the view one column/character left, unless the left-most
column/character for the terminal is reached.

    Vedeu.trigger(:_view_left_, name)
    Vedeu.trigger(:_view_left_, Vedeu.focus)

    Vedeu.trigger(:_geometry_left_, name)
    Vedeu.trigger(:_geometry_left_, Vedeu.focus)

Note: `name` is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.
