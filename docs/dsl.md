# @title The Vedeu DSL

Coupled with the API (for interacting with the running client application), the
 DSL provides the mechanism to configure aspects of your application whilst
 using Vedeu.

### Interfaces

An Interface is a basic element in the GUI. It usually but does not necessarily
correspond to a region of the terminal screen (for example, an Interface might
not be displayed at certain points in an application life cycle).

Much of the behavior of an Interface comes from child objects that are defined
under the Interface. These objects are described in more detail in their
respective sections below.

Here is an example of declarations for an `interface` block:

```ruby
interface 'main' do
  visible true # whether to show the interface
  focus! # focus this interface
  cursor true # Show the cursor when this section is focused
  colour foreground: '#ffffff', # set interface foreground
         background: '#000033'  # and background colors
  group 'general' # set interface group

  geometry do
    # size and position details
  end
  border do
    # border properties
  end
  keymap do
    # keymap that is in effect when this interface is focused
  end
  views do
    # details about how to render the interface
  end
end
```

### Declaring interface sub-objects

Every object in the DSL besides interface itself is defined for a particular
interface. This can either be declared implicitly by defining the object inside
an `interface` block or explicitly, by passing the interface name as a first
argument to the declaration.

That is, these are equivalent ways to declare a Geometry for an existing
interface

```ruby
interface 'main' do
  geometry do
    # some geometry
  end

  # some other declarations
end
```

or you can say

```ruby
interface 'main' do
  # some other declarations
end

geometry 'main' do
  # some geometry
end
```

## Borders

{include:Vedeu::DSL::Border}

### Setting a title for the border

{include:Vedeu::DSL::Border#title}

### Customising the appearance of the border

{include:Vedeu::DSL::Border#bottom_left}
{include:Vedeu::DSL::Border#bottom_right}
{include:Vedeu::DSL::Border#horizontal}
{include:Vedeu::DSL::Border#top_left}
{include:Vedeu::DSL::Border#top_right}
{include:Vedeu::DSL::Border#vertical}

### Enabling/disabling the border

{include:Vedeu::DSL::Border#enable!}
{include:Vedeu::DSL::Border#disable!}

### Enabling/disabling an aspect of the border

{include:Vedeu::DSL::Border#bottom}
{include:Vedeu::DSL::Border#left}
{include:Vedeu::DSL::Border#right}
{include:Vedeu::DSL::Border#top}

## Geometry

{include:Vedeu::DSL::Geometry}

### Setting the interface dimensions

{include:Vedeu::DSL::Geometry#centred}
{include:Vedeu::DSL::Geometry#height}
{include:Vedeu::DSL::Geometry#width}
{include:Vedeu::DSL::Geometry#columns}
{include:Vedeu::DSL::Geometry#rows}
{include:Vedeu::DSL::Geometry#x}
{include:Vedeu::DSL::Geometry#xn}
{include:Vedeu::DSL::Geometry#y}
{include:Vedeu::DSL::Geometry#yn}

## Groups

{include:Vedeu::DSL::Group}

### Add interfaces to groups

{include:Vedeu::DSL::Group.group}

## Keymaps

{include:Vedeu::DSL::Keymap}
{include:Vedeu::DSL::Keymap.keymap}
{include:Vedeu::DSL::Keymap#name}

## Menus

{include:Vedeu::DSL::Menu}
{include:Vedeu::DSL::Menu#item}
{include:Vedeu::DSL::Menu#items}
{include:Vedeu::DSL::Menu#name}

## Views

{include:Vedeu::DSL::View.interface}

### Immediate rendering

{include:Vedeu::DSL::View.render}

### Deferred rendering

{include:Vedeu::DSL::View.view}

### Specifying view content

{include:Vedeu::DSL::Line}
{include:Vedeu::DSL::Line#line}
{include:Vedeu::DSL::Line#streams}

`@todo` More documentation coming soon.

