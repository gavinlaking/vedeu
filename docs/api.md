# @title Vedeu API
# The Vedeu API

Vedeu provides a simple DSL for the creation of terminal/console based
applications. Below is a list of all the API methods:

    class OtherClassInYourApplication
      # ...

      def some_method
        Vedeu.some_api_method
      end

      # ...
    end

Most of Vedeu's core functionality comes from its API methods, these
methods are used in a variety of ways, sometimes in combination:

    # with parameters
    Vedeu.method_name(*params)

    # with a block
    Vedeu.method_name(*params) do
      # ...
    end

    # with other methods
    Vedeu.method_name.other_method

Nearly all of the API methods have associated
{file:docs/events.md Vedeu Events} which you can bind to or trigger to
achieve the same effect. It is favoured that you trigger events
instead of calling API methods as this gives you a bit more visibility
when debugging, and flexibility when running your application.
However, how you build your application is up to you! (Of course!)

## Configuration

See {file:docs/configuration.md}

## Events

See {file:docs/events.md}

## Input

### Vedeu.keypress
### Vedeu.keymap
  - key
  - name
  - interface

## Interfaces

### Vedeu.interface
  - background
  - border
  - cursor
  - colour
  - delay
  - focus!
  - foreground
  - geometry
    - align
    - align_left
    - align_center
    - align_centre
    - align_right
    - align_top
    - align_middle
    - align_bottom
    - horizontal_alignment
    - vertical_alignment
    - height
    - width
    - x
    - y
  - group
  - keymap
    - key
    - name
    - interface
  - line
  - name
  - style
  - use

## Views

### Vedeu.renders
### Vedeu.render
  - view
    - colour
    - cursor
    - geometry
      - height
      - width
      - x
      - y
    - line
      - background
      - colour
      - foreground
      - stream
        - align
        - background
        - colour
        - foreground
        - style
        - text
        - width
      - streams
        - stream
      - text
      - style
    - lines
      - line
    - name
    - style
  - use

### Vedeu.views
  - ... as #renders

## Menus

### Vedeu.menu
  - items
  - name

## Renderers

### Vedeu.renderer


# API Methods

### Vedeu.add_command

@todo Add more documentation.

### Vedeu.add_keypress

@todo Add more documentation.

### Vedeu.all_commands

Returns an array of all commands received by Vedeu.

@todo Add more documentation.

### Vedeu.all_keypresses

Returns an array of all keypresses received by Vedeu.

@todo Add more documentation.

### Vedeu.background_colours

Repository method. Access registered background colours.

    Vedeu.background_colours # => [Vedeu::Colours::Backgrounds]

    Vedeu.background_colours.all # => [Hash<String => String>]


### Vedeu.bind

@todo Add more documentation.

### Vedeu.bind_alias

@todo Add more documentation.

### Vedeu.border

See {Vedeu::DSL::Border::ClassMethods.border}

### Vedeu.borders

Repository method. Access registered borders.

    Vedeu.borders # [Vedeu::Borders::Repository]

    Vedeu.borders.all # [Array<Vedeu::Borders::Border>]

### Vedeu.bound?

@todo Add more documentation.

### Vedeu.buffer_update

@todo Add more documentation.

### Vedeu.buffer_write

@todo Add more documentation.

### Vedeu.buffers

Repository method. Access registered borders.

    Vedeu.buffers # [Vedeu::Buffers::Repository]

    Vedeu.buffers.all # [Array<Vedeu::Buffers::Buffer>]

### Vedeu.clear

@todo Add more documentation.

### Vedeu.clear_by_group

@todo Add more documentation.

### Vedeu.clear_by_name

@todo Add more documentation.

### Vedeu.clear_content_by_name

@todo Add more documentation.

### Vedeu.clock_time

@todo Add more documentation.

### Vedeu.configuration

@todo Add more documentation.

### Vedeu.configure

@todo Add more documentation.

### Vedeu.cursor

@todo Add more documentation.

### Vedeu.cursors

Repository method. Access registered cursors.

    Vedeu.cursors # [Vedeu::Cursors::Repository]

    Vedeu.cursors.all # [Array<Vedeu::Cursors::Cursor>]

### Vedeu.direct_write

@todo Add more documentation.

### Vedeu.documents

@todo Add more documentation.

### Vedeu.drb_restart

@todo Add more documentation.

### Vedeu.drb_start

@todo Add more documentation.

### Vedeu.drb_status

@todo Add more documentation.

### Vedeu.drb_stop

@todo Add more documentation.

### Vedeu.events

Repository method. Access registered events.

    Vedeu.events # [Vedeu::Events::Repository]

    Vedeu.events.all # [Array<Vedeu::Events::Collection>]

### Vedeu.exit

@todo Add more documentation.

### Vedeu.focus

@todo Add more documentation.

### Vedeu.focus?

@todo Add more documentation.

### Vedeu.focus_by_name

@todo Add more documentation.

### Vedeu.focus_next

@todo Add more documentation.

### Vedeu.focus_previous

@todo Add more documentation.

### Vedeu.focussed?

@todo Add more documentation.

### Vedeu.foreground_colours

Show all the registered foreground colours.

    Vedeu.foreground_colours.all # => [Hash<String => String>]

    Vedeu.foreground_colours # => [Vedeu::Colours::Foregrounds]

### Vedeu.geometries

Repository method. Access registered interface/view geometry.

    Vedeu.geometries # [Vedeu::Geometries::Repository]

    Vedeu.geometries.all # [Array<Vedeu::Geometries::Geometry>]

### Vedeu.geometry

@todo Add more documentation.

### Vedeu.goto

@todo Add more documentation.

### Vedeu.group

@todo Add more documentation.

### Vedeu.groups

Repository method. Access registered groups.

    Vedeu.groups # [Vedeu::Groups::Repository]

    Vedeu.groups.all # [Array<Vedeu::Groups::Group>]

### Vedeu.height

@todo Add more documentation.

### Vedeu.hide_cursor

See {file:docs/cursors.md#vedeuhide_cursor__}

### Vedeu.hide_group

@todo Add more documentation.

### Vedeu.hide_interface

@todo Add more documentation.

### Vedeu.interface

@todo Add more documentation.

### Vedeu.interfaces

Repository method. Access registered interfaces.

    Vedeu.interfaces # [Vedeu::Interfaces::Repository]

    Vedeu.interfaces.all # [Array<Vedeu::Interfaces::Interface>]

### Vedeu.keymap

@todo Add more documentation.

### Vedeu.keymaps

Repository method. Access registered keymaps.

    Vedeu.keymaps # [Vedeu::Input::Repository]

    Vedeu.keymaps.all # [Array<Vedeu::Input::Keymap>]

### Vedeu.keypress

@todo Add more documentation.

### Vedeu.keys

@todo Add more documentation.

### Vedeu.last_command

Returns the last command entered into Vedeu.

@todo Add more documentation.

### Vedeu.last_keypress

Returns the last keypress entered into Vedeu.

@todo Add more documentation.

### Vedeu.log

@todo Add more documentation.

### Vedeu.log_stderr

@todo Add more documentation.

### Vedeu.log_stdout

@todo Add more documentation.

### Vedeu.log_timestamp

@todo Add more documentation.

### Vedeu.menu

@todo Add more documentation.

### Vedeu.menus

Repository method. Access registered menus.

    Vedeu.menus # [Vedeu::Menus::Repository]

    Vedeu.menus.all # [Array<Vedeu::Menus::Menu>]

### Vedeu.profile

@todo Add more documentation.

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

### Vedeu.ready!

@todo Add more documentation.

### Vedeu.ready?

@todo Add more documentation.

### Vedeu.refresh

@todo Add more documentation.

### Vedeu.render

@todo Add more documentation.

### Vedeu.render_output

@todo Add more documentation.

### Vedeu.renderer

@todo Add more documentation.

### Vedeu.renderers

Repository method. Access registered renderers.

    Vedeu.renderers # [Vedeu::Renderers]

### Vedeu.renders

@todo Add more documentation.

### Vedeu.renders

@todo Add more documentation.

### Vedeu.resize

@todo Add more documentation.

### Vedeu.show_cursor

See {file:docs/cursors.md#vedeushow_cursor__}

### Vedeu.show_group

@todo Add more documentation.

### Vedeu.show_interface

@todo Add more documentation.

### Vedeu.timer

@todo Add more documentation.

### Vedeu.toggle_cursor

See {file:docs/cursors.md#vedeutoggle_cursor__}

### Vedeu.toggle_group

@todo Add more documentation.

### Vedeu.toggle_interface

@todo Add more documentation.

### Vedeu.trigger

@todo Add more documentation.

### Vedeu.unbind

@todo Add more documentation.

### Vedeu.view

@todo Add more documentation.

### Vedeu.views

@todo Add more documentation.

### Vedeu.width

@todo Add more documentation.

### Vedeu.write

This allows the direct writing to the terminal, unencumbered by the
framework.

@todo Add more documentation.
