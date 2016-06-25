### `:_refresh_view_`

Will cause the named view to refresh.

    Vedeu.trigger(:_refresh_view_, name)

This event will only actually trigger if Vedeu is ready. Vedeu will
check this via `Vedeu.ready?`.
