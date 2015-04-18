Coupled with the API (for interacting with the running client application), the
 DSL provides the mechanism to configure aspects of your application whilst
 using Vedeu.


### Borders

Borders are defined by name for each of the client application's interfaces or
 views. They can be enabled or disabled (which controls whether they are
 rendered or not), they have their own colours and styles, and each aspect of
 the border can be controlled. The RubyDoc contains information for
 configuring borders.

### Geometry

Geometry is defined by name and allows the configuration of the position and
 size of an interface.

### Groups

Interfaces can be configured to be part of a named group. Once an interface is a
 member of group, the group can be affected by other controls. For example,
 assuming the client application is a simple Git client, it may have a group
 called 'commit'. The 'commit' group will contain the interfaces 'diff' (to show
 the changes), 'staged' (to show which files are staged) and 'unstaged'. A
 refresh of the 'commit' group would cause all interfaces belonging to the group
 to refresh. Similarly, showing or hiding the group would of course, show or
 hide the interfaces of that group.

### Interfaces



### Keymaps

There are two built in keymaps with Vedeu, 'system' (keys needed by Vedeu to
 operate, e.g. 'q' for quit, to quit the client application), and 'global' which
 holds keys which perform actions no matter which interface is currently
 focussed.

You can define keymaps by name which matches a defined interface. When that
 interface is in focus, keys pressed as part of this definition will affect
 that interface. This allows you to form context driven behaviour for your
 application.


### Menus



### Views



