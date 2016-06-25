### `:_set_border_caption_`

This event changes the caption of the border of the named view to the
value given.

    Vedeu.trigger(:_set_border_caption_, name, caption)

- The caption must be a string or nil.
- If the caption is an empty string or nil, then the caption will not
  be shown, and an existing caption will be removed.
- If the name is nil, or references a border that does not exist, then
  the caption will be silently discarded.
