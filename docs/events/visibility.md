# @title Vedeu Visibility Events

## Visibility Events

Note: 'name' is a Symbol unless mentioned otherwise.

### :_clear_
Clears the whole terminal space.

    Vedeu.trigger(:_clear_)
    Vedeu.clear

### :_clear_group_
Clears the spaces occupied by the interfaces belonging to the named
group.

    Vedeu.trigger(:_clear_group_, name)
    Vedeu.clear_by_group(name)

### :_clear_view_
Clears the named view/interface area.

    Vedeu.trigger(:_clear_view_, name)
    Vedeu.clear_by_name(name)

### :_clear_view_content_
Clears only the content of the named view/interface area.

    Vedeu.trigger(:_clear_view_content_, name)
    Vedeu.clear_content_by_name(name)

### :_hide_cursor_
Hide the cursor of the named interface or when a name is not given,
the interface currently in focus.

    Vedeu.trigger(:_hide_cursor_, name)
    Vedeu.trigger(:_cursor_hide_, name)
    Vedeu.hide_cursor(name)

### :_hide_group_
Hiding a group of interfaces.

    Vedeu.trigger(:_hide_group_, name)
    Vedeu.hide_group(name)

### :_hide_interface_
Hide an interface by name.

    Vedeu.trigger(:_hide_interface_, name)
    Vedeu.hide_interface(name)

### :_show_cursor_
Show the cursor of the named interface or when a name is not given,
the interface currently in focus.

    Vedeu.trigger(:_show_cursor_, name)
    Vedeu.trigger(:_cursor_show_, name)
    Vedeu.show_cursor(name)

### :_show_group_
Showing a group of interfaces.

    Vedeu.trigger(:_show_group_, name)
    Vedeu.show_group(name)

### :_show_interface_
Show an interface by name.

    Vedeu.trigger(:_show_interface_, name)
    Vedeu.show_interface(name)

### :_toggle_cursor_
Toggling a cursor.

    Vedeu.trigger(:_toggle_cursor_, name)
    Vedeu.toggle_cursor(name)

### :_toggle_group_
Toggling a group of interfaces.

    Vedeu.trigger(:_toggle_group_, name)
    Vedeu.toggle_group(name)

### :_toggle_interface_
Toggling an interface.

    Vedeu.trigger(:_toggle_interface_, name)
    Vedeu.toggle_interface(name)
