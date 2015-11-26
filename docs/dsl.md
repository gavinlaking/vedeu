# @title The Vedeu DSL
# The Vedeu DSL

Coupled with the API (for interacting with the running client
application), the DSL provides the mechanism to configure aspects of
your application whilst using Vedeu.

## Interfaces

An Interface is a basic element in the GUI. You can think of it as a
container for a portion of the terminal screen. Interfaces can be set
to be show or hidden, and combined into groups to form the different
'screens' of your application.

Much of the behavior of an Interface comes from child objects that
are defined under the Interface. These objects are described in more
detail in their respective sections below.

Here is an example of declarations for an `interface` block:

```ruby
interface :main do
  visible true # whether to show the interface
  focus! # focus this interface
  cursor true # Show the cursor when this section is focused
  colour foreground: '#ffffff', # set interface foreground
         background: '#000033'  # and background colors
  group :general # set interface group

  geometry do
    # size and position details
  end
  border do
    # border properties
  end
  keymap do
    # keymap that is in effect when this interface is focused
  end
end
```

The content for an interface is handled by a 'view'. More details on
these can be found here: {file:docs/dsl.md#Views Views}

### Declaring interface sub-objects

Every object in the DSL besides interface itself is defined for a
particular interface. This can either be declared implicitly by
defining the object inside an `interface` block or explicitly, by
passing the interface name as a first argument to the declaration.

That is, these are equivalent ways to declare a Geometry for an
existing interface

```ruby
interface :main do
  geometry do
    # some geometry
  end

  # some other declarations
end
```

or you can say

```ruby
interface :main do
  # some other declarations
end

geometry :main do
  # some geometry
end
```

## Borders

{include:Vedeu::Borders::DSL}

### Creating a new named border

{include:Vedeu::Borders::DSL.border}

### Setting a title for the border

{include:Vedeu::Borders::DSL#title}

### Customising the appearance of the border

{include:Vedeu::Borders::DSL#bottom_left}
{include:Vedeu::Borders::DSL#bottom_right}
{include:Vedeu::Borders::DSL#horizontal}
{include:Vedeu::Borders::DSL#top_left}
{include:Vedeu::Borders::DSL#top_right}
{include:Vedeu::Borders::DSL#vertical}

### Enabling/disabling the border

{include:Vedeu::Borders::DSL#enable!}
{include:Vedeu::Borders::DSL#disable!}

### Enabling/disabling an aspect of the border

{include:Vedeu::Borders::DSL#bottom}
{include:Vedeu::Borders::DSL#left}
{include:Vedeu::Borders::DSL#right}
{include:Vedeu::Borders::DSL#top}

## Geometry

{include:Vedeu::Geometries::DSL}

### Creating a new named geometry

{include:Vedeu::Geometries::DSL.geometry}

### Setting the interface dimensions

{include:Vedeu::Geometries::DSL#align}
{include:Vedeu::Geometries::DSL#align_left}
{include:Vedeu::Geometries::DSL#align_centre}
{include:Vedeu::Geometries::DSL#align_right}
{include:Vedeu::Geometries::DSL#align_top}
{include:Vedeu::Geometries::DSL#align_middle}
{include:Vedeu::Geometries::DSL#align_bottom}
{include:Vedeu::Geometries::DSL#horizontal_alignment}
{include:Vedeu::Geometries::DSL#vertical_alignment}
{include:Vedeu::Geometries::DSL#height}
{include:Vedeu::Geometries::DSL#width}
{include:Vedeu::Geometries::DSL#columns}
{include:Vedeu::Geometries::DSL#rows}
{include:Vedeu::Geometries::DSL#x}
{include:Vedeu::Geometries::DSL#xn}
{include:Vedeu::Geometries::DSL#y}
{include:Vedeu::Geometries::DSL#yn}

## Groups

{include:Vedeu::Groups::DSL}

### Creating a new named group

{include:Vedeu::Groups::DSL.group}

### Add interfaces to groups

{include:Vedeu::Groups::DSL#add}

## Keymaps

{include:Vedeu::Input::DSL}
{include:Vedeu::Input::DSL#name}

### Creating a new named group

{include:Vedeu::Input::DSL.keymap}

## Menus

{include:Vedeu::Menus::DSL}
{include:Vedeu::Menus::DSL#item}
{include:Vedeu::Menus::DSL#items}
{include:Vedeu::Menus::DSL#name}

### Creating a new named menu

{include:Vedeu::Menus::DSL.menu}

## Views

{include:Vedeu::DSL::View}
{include:Vedeu::Interfaces::DSL.interface}

### Immediate rendering

{include:Vedeu::DSL::View.renders}

### Deferred rendering

{include:Vedeu::DSL::View.views}

### Specifying view content

{include:Vedeu::DSL::Line}
{include:Vedeu::DSL::Line#line}
{include:Vedeu::DSL::Line#streams}

`@todo` More documentation coming soon.

#### Authors Notes

The Rubydoc documentation has more specific information about the DSL
methods demonstrated above: [RubyDoc](http://rubydoc.info/gems/vedeu).

I've tried to write the DSL in a way which makes it read nice;
believing that this will make it easier to use. I hope this is the
case for you.
