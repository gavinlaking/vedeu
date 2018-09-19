# @title Vedeu Borders
# Vedeu Borders

The interfaces of Vedeu can each have their own border.

- It has a name. This name associates it with an
  {file:docs/interfaces.md Interface}.
- Each of its corners, the horizontal, and the vertical characters can
  be defined as different characters, with custom colours and styles.
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

## Border DSL

{include:file:docs/dsl/borders.md}

## Border Events

Note: 'name' is a Symbol unless mentioned otherwise, and can be
substituted for `Vedeu.focus` to use the interface currently in focus.

{include:file:docs/events/by_name/refresh_border.md}

{include:file:docs/events/by_name/set_border_title.md}

{include:file:docs/events/by_name/set_border_caption.md}
