### Vedeu.read

This allows the direct reading from the terminal, unencumbered by the
framework.

    Vedeu.read("some input here") # => programmatic cooked mode
                                  #    (default)

    Vedeu.read("\e[24;2~", mode: :raw) # => programmatic raw mode
                                       #    (provides :shift_f12 in
                                       #    this example)

    Vedeu.read(nil, mode: :raw) # => for a single keypress

    Vedeu.read(nil, mode: :cooked) # => (default mode) for a 'line at
                                   #    a time' (pressing 'return'
                                   #    ends the line)

The way that these are used will depend on the mode your terminal is currently set to. Vedeu by default sets this to `:raw` (single character, hidden cursor). `Vedeu.read` by default expects the terminal to be in `:cooked` mode unless you provide the `mode: :raw` option.

- In `:cooked` mode (default), it will trigger a `:_command_` event
  with the input provided, meaning you should bind to :command to
  receive the input.
- In `:raw` mode, it will trigger a `:_keypress_` event with the input
  provided, meaning you should bind to `:key` to receive the input.

You can also access the input given using the API methods:

    Vedeu.all_commands
    Vedeu.all_keypresses
    Vedeu.last_command
    Vedeu.last_keypress

