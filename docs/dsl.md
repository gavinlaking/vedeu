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

### Borders

Borders are defined by name for each of the client application's interfaces or
 views. They can be enabled or disabled (which controls whether they are
 rendered or not), they have their own colours and styles, and each aspect of
 the border can be controlled. The RubyDoc contains information for
 configuring borders.

### Geometry

Geometry allows the configuration of the position and size of an interface.

Here is an example of declarations for a `geometry` block:

 ```ruby
interface 'main' do
  geometry do
    height 5 # Sets the height of the view to 5
    width 20 # Sets the width of the view to 20
    x 3 # Start drawing 3 spaces from left
    y 10 # Start drawing 10 spaces from top
    xn 30 # Stop drawing 30 spaces from the left
    yn 20 # Stop drawing 20 spaces from top
  end
end
```

If a declaration is omitted for `height` or `width` the full remaining space
available in the terminal will be used. `x` and `y` both default to 0.

You can also make a geometry declaration dependent on another view:

 ```ruby
interface 'other_panel' do
  # other code ...
end

interface 'main' do
  geometry do
    height 10
    y { use('other_panel').south }
  end
end
```

This view will begin just below "other\_panel".

### Groups

Interfaces can be configured to be part of a named group. Once an interface is a
 member of group, the group can be affected by other controls. For example,
 assuming the client application is a simple Git client, it may have a group
 called 'commit'. The 'commit' group will contain the interfaces 'diff' (to show
 the changes), 'staged' (to show which files are staged) and 'unstaged'. A
 refresh of the 'commit' group would cause all interfaces belonging to the group
 to refresh. Similarly, showing or hiding the group would of course, show or
 hide the interfaces of that group.

### Keymaps

You can define keymaps by name which matches a defined interface. When that
 interface is in focus, keys pressed as part of this definition will affect
 that interface. This allows you to form context driven behaviour for your
 application.


### Menus



### Views



