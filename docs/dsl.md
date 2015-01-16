Key

& = This is a module of DSL methods.
* = This method name is an alias to its parent.
- = This method is deprecated.
~ = Needs work.
√ = Completed.

DSL
  & Colour
    ~ background
      ~ *bg
      ~ *bgcolor
    ~ foreground
      ~ *fg
      ~ *fgcolor
    ~ colour

  Configuration
    √ configure
    ~ configuration
    ~ interactive
      ~ *interactive!
    ~ standalone
      ~ *standalone!
    ~ run_once
      ~ run_once!
    ~ cooked
      ~ *cooked!
    ~ raw
      ~ *raw!
    ~ debug
      ~ *debug!
    ~ trace
      ~ *trace!
    ~ colour_mode
    ~ log
    ~ exit_key
    ~ focus_next_key
    ~ focus_prev_key
    ~ mode_switch_key

  Composition
    ~ render
      ~ *renders
    √ view
      √ *interfaces
    √ views
      √ *composition

  Events
    √ bind
    √ trigger
    √ unbind

  Focus
    ~ focus

  Geometry
    √ centred
      √ *centred!
    √ height
    √ name
    √ width
    √ x
    √ y

  Interface
    ~ border
    √ cursor
    √ cursor!
    √ delay
    ~ focus!
    √ group
    √ geometry
    ~ keys
    ~ lines
    √ name
    ~ use
    -centred
      -*centred!
    -height
    -line
    -width
    -x
    -y

  Keymap
    √ interface
      √ *interfaces
    ~ key
    ~ keypress

  Line
    ~ line
    √ stream
    √ streams
    √ text
      √ *line
      √ *stream

  Menu
    √ item
    √ items
    ~ menu
    √ name

  Stream
    √ align
      √ *left
      √ *center
      √ *centre
      √ *right
    √ text
    -width

  & Style
    √ style
      √ *styles

  Terminal
    √ height
    √ resize
    √ width
