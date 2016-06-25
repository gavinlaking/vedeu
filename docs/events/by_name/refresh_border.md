### `:_refresh_border_`

This event refreshes the border of the named view.

- If a name is not given, then the currently focussed view will be
  refreshed as defined by `Vedeu.focus`.
- If the view does not have a border or the border is not enabled,
  this event is silently ignored.

    Vedeu.trigger(:_refresh_border_, name)
