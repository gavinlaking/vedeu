# @title Vedeu Cells
# Vedeu Cells

- A cell represents a single character in the visible terminal space.
  We could use {file:docs/chars.md Characters} for this, but sometimes
  a character is empty, and only has a colour and/or style.
- Cells also represent individual terminal escape sequences. Although
  most are not visible, in order to correctly render a TTY, they are
  used.
