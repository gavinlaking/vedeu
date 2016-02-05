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

### Vedeu.cursors

Repository method. Access registered cursors.

    Vedeu.cursors # [Vedeu::Cursors::Repository]

    Vedeu.cursors.all # [Array<Vedeu::Cursors::Cursor>]

### Vedeu.events

Repository method. Access registered events.

    Vedeu.events # [Vedeu::Events::Repository]

    Vedeu.events.all # [Array<Vedeu::Events::Events>]

### Vedeu.foreground_colours

Show all the registered foreground colours.

    Vedeu.foreground_colours.all # => [Hash<String => String>]

    Vedeu.foreground_colours # => [Vedeu::Colours::Foregrounds]

### Vedeu.geometries

Repository method. Access registered interface/view geometry.

    Vedeu.geometries # [Vedeu::Geometries::Repository]

    Vedeu.geometries.all # [Array<Vedeu::Geometries::Geometry>]


### Vedeu.groups

Repository method. Access registered groups.

    Vedeu.groups # [Vedeu::Groups::Repository]

    Vedeu.groups.all # [Array<Vedeu::Groups::Group>]

### Vedeu.interfaces

Repository method. Access registered interfaces.

    Vedeu.interfaces # [Vedeu::Interfaces::Repository]

    Vedeu.interfaces.all # [Array<Vedeu::Interfaces::Interface>]

### Vedeu.keymaps

Repository method. Access registered keymaps.

    Vedeu.keymaps # [Vedeu::Input::Repository]

    Vedeu.keymaps.all # [Array<Vedeu::Input::Keymap>]

### Vedeu.menus

Repository method. Access registered menus.

    Vedeu.menus # [Vedeu::Menus::Repository]

    Vedeu.menus.all # [Array<Vedeu::Menus::Menu>]


### Vedeu.renderers

Repository method. Access registered renderers.

    Vedeu.renderers # [Vedeu::Renderers]

