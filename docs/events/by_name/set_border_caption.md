### `:_set_border_caption_`
This event changes the caption of the border of the named view to the
value given.

    Vedeu.trigger(:_set_border_caption_, name, caption)

- The caption must be a string or nil.
- If the caption is an empty string or nil, then the caption will not
  be shown, and an existing caption will be removed.
- If the name is nil, then the view currently focussed will be used.
- When triggering this event, the border will automatically be
  refreshed, unless the view does not have a border, or the border is
  not enabled, or the bottom border is set not to be shown.
