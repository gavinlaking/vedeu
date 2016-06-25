### `:_set_border_title_`

This event changes the title of the border of the named view to the
value given.

    Vedeu.trigger(:_set_border_title_, name, title)

- The title must be a string or nil.
- If the title is an empty string or nil, then the title will not be
  shown, and an existing title will be removed.
- If the name is nil, or references a border that does not exist, then
  the caption will be silently discarded.
