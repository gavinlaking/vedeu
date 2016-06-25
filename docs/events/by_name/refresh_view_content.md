### `:_refresh_view_content_`

Will cause only the content of the named view to refresh.

    Vedeu.trigger(:_refresh_view_content_, name)

This event will only actually trigger if Vedeu is ready. Vedeu will
check this via `Vedeu.ready?`.
