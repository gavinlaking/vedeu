# @title Visibility Events

## Visibility Events

### Hiding the cursor

    Vedeu.trigger(:_hide_cursor_, name)
    Vedeu.trigger(:_cursor_hide_, name)

Hide the cursor of the named interface or if a name is not given, the interface currently in focus. Also available as:

    Vedeu.hide_cursor(name)


### Showing the cursor

    Vedeu.trigger(:_show_cursor_, name)
    Vedeu.trigger(:_cursor_show_, name)

Show the cursor of the named interface or if a name is not given, the interface currently in focus. Also available as:

    Vedeu.show_cursor(name)


### Hiding a group

    Vedeu.trigger(:_hide_group_, group_name)

Will hide all of the interfaces belonging to the named group. Useful for
hiding part of that which is currently displaying in the terminal.

This may be rarely used, since the action of showing a group
will effectively clear the terminal and show the new group.


### Showing a group

    Vedeu.trigger(:_show_group_, group_name)

Will clear the terminal and then show all of the interfaces belonging to the named group.


### Hiding an interface

    Vedeu.trigger(:_hide_interface_, name)

See: {Vedeu::Buffer#hide}


### Showing an interface

    Vedeu.trigger(:_show_interface_, name)

See: {Vedeu::Buffer#show}


### Toggling an interface

    Vedeu.trigger(:_toggle_interface_, name)

See: {Vedeu::Buffer#toggle}
