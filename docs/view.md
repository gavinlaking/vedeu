# @title Vedeu Views
# Vedeu Views

Each interface defined in Vedeu will have an associated (by name, of
course) view. This view will contain that which is visible within the
interface and is determined by the position of the cursor associated
with the interface.

- A view is made up of lines, made up of characters.
- Lines can have their own background, foreground and styles.
- A line can also be made up of streams, a stream itself having its
  own background, foreground and styles.
- Lines and streams are made up of characters- again, each with their
  own background, foreground and styles.

Views can be requested to be drawn immediately on construction, or
added to a {file:docs/buffer.md Buffer}.
