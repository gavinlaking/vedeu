### `:_unmaximise_`

Will unmaximise the named interface geometry. Previously, when a
geometry was maximised, then triggering the unmaximise event will
return it to its usual defined size (terminal size permitting: when
the terminal has been resized, then the new geometry size should
adapt).

    Vedeu.trigger(:_unmaximise_, name)
