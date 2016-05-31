### `:_movement_refresh_`

When triggered, triggers additional events which aid the updating of
the output. Used when moving an interface/view.

    Vedeu.trigger(:_movement_refresh_, name)

At this time, triggering this event will:

- Clear the entire terminal (assuming at least one renderer is the
  default (Vedeu::Renderer::Terminal)). This action is performed when
  moving an interface/view so that there are no 'artefacts' left
  behind.
- Refresh the entire terminal (as above). This means all visible
  interfaces are re-rendered. This action is performed to ensure other
  views currently visible are rendered in their current position.
- Clears the named view. This action removes the named view from the
  terminal (or output).
- Refreshes the named view. This action adds the named view to the
  terminal (or output); in the new position.
