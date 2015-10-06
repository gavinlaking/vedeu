# @title Vedeu Interfaces
# Vedeu Interfaces

Think of interfaces as being discrete sections of the terminal space.

- It has a name, which all other aspects of Vedeu will be related.
- It has a size, in terms of a width and height, determined by
  {file:docs/geometry.md Geometry}.
- It can have a {file:docs/border.md} Border.
- It can be part of a {file:docs/group.md Group}.
- An interface is empty unless it has an associated
  {file:docs/view.md View}.
- It can have a default background and foreground colour which you
  can later override with the view.
- It can also have a default style, which again, can be overriden if
  you wish.
- It can be visible or invisible, even independently of the group
  you have assigned them to. By default, all interfaces are invisible
  unless you specifically define them to be visible.
- Interfaces can move or resize on the screen by controlling its
  Geometry or if the terminal change dimensions.
