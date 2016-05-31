### `:_refresh_`

Refreshes all registered interfaces.

The interfaces will be refreshed in z-index order, meaning that
interfaces with a lower z-index will be drawn first. This means
overlapping interfaces will be drawn as specified. Hidden interfaces
will be still refreshed in memory but not shown.

    Vedeu.trigger(:_refresh_)
