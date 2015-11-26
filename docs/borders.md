# @title Vedeu Borders
# Vedeu Borders

The interfaces of Vedeu can each have their own border.

- It has a name. This name associates it with an
  {file:docs/interface.md Interface}.
- Each of its corners, the horizontal, and the vertical character can
  be defined as different characters.
- It can have a foreground and a background and style, independent of
  the interface to which it belongs.
- Each of the sides of the border can be shown or hidden
  independently.
- The border itself can be enabled and disabled (shown/hidden) as
  required.
- The border can have a title, which is displayed on the top side.
- It can also have a caption, which is displayed on the bottom side.
- The sides of the border will use:
  - The first (top) line of the geometry.
  - The last (bottom) line of the geometry.
  - The first character (left) of the geometry.
  - The last character (right) of the geometry.
- The border can be refreshed independently of the interface.

## Border Events

Note: 'name' is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.

### `:_refresh_border_`
This event refreshes the border of the named view, unless the view
does not have a border, or the border is not enabled.

    Vedeu.trigger(:_refresh_border_, name)

### `:_set_border_title_`
This event changes the title of the border of the named view to the
value given.

    Vedeu.trigger(:_set_border_title_, name, title)

- The title must be a string or nil.
- If the title is an empty string or nil, then the title will not be
  shown, and an existing title will be removed.
- If the name is nil, then the view currently focussed will be used.
- When triggering this event, the border will automatically be
  refreshed, unless the view does not have a border, or the border is
  not enabled, or the top border is set not to be shown.

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
