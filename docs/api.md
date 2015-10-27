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

## Borders

### Vedeu.border

## Geometry

### Vedeu.geometry

## Groups

### Vedeu.group

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
### Vedeu.renderers

## Repositories

These are collections which you can access:

### Vedeu.background_colours
### Vedeu.foreground_colours
### Vedeu.borders
### Vedeu.buffers
### Vedeu.cursors
### Vedeu.events
### Vedeu.geometries
### Vedeu.groups
### Vedeu.interfaces
### Vedeu.keymaps
### Vedeu.menus

## Miscellany

### Vedeu.cursor
### Vedeu.focus
### Vedeu.focus_by_name
### Vedeu.focussed?
### Vedeu.focus_next
### Vedeu.focus_previous
### Vedeu.height
### Vedeu.log
### Vedeu.log_stdout
### Vedeu.log_stderr
### Vedeu.resize
### Vedeu.timer
### Vedeu.width
