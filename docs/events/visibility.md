# @title Vedeu Visibility Events

## Visibility Events

Note: 'name' is a Symbol unless mentioned otherwise.

### `:\_clear\_`
See {Vedeu::Terminal::Buffer#clear}

### `:\_clear_group\_`
Clears the spaces occupied by the interfaces belonging to the named
group.

    Vedeu.trigger(:_clear_group_, name)
    Vedeu.clear_by_group(name)

### `:\_clear_view\_`
Clears the named view/interface area.

    Vedeu.trigger(:_clear_view_, name)
    Vedeu.clear_by_name(name)

### `:\_clear_view_content\_`
Clears only the content of the named view/interface area.

    Vedeu.trigger(:_clear_view_content_, name)
    Vedeu.clear_content_by_name(name)

### `:\_hide_cursor\_`
Hide the cursor of the named interface or when a name is not given,
the interface currently in focus.

    Vedeu.trigger(:_hide_cursor_, name)
    Vedeu.trigger(:_cursor_hide_, name)
    Vedeu.hide_cursor(name)

### `:\_hide_group\_`
Hiding a group of interfaces.

    Vedeu.trigger(:_hide_group_, name)
    Vedeu.hide_group(name)

### `:\_hide_interface\_`
Hide an interface by name.

    Vedeu.trigger(:_hide_interface_, name)
    Vedeu.hide_interface(name)

### `:\_show_cursor\_`
Show the cursor of the named interface or when a name is not given,
the interface currently in focus.

    Vedeu.trigger(:_show_cursor_, name)
    Vedeu.trigger(:_cursor_show_, name)
    Vedeu.show_cursor(name)

### `:\_show_group\_`
Showing a group of interfaces.

    Vedeu.trigger(:_show_group_, name)
    Vedeu.show_group(name)

### `:\_show_interface\_`
Show an interface by name.

    Vedeu.trigger(:_show_interface_, name)
    Vedeu.show_interface(name)

### `:\_toggle_cursor\_`
Toggling a cursor.

    Vedeu.trigger(:_toggle_cursor_, name)
    Vedeu.toggle_cursor(name)

### `:\_toggle_group\_`
Toggling a group of interfaces.

    Vedeu.trigger(:_toggle_group_, name)
    Vedeu.toggle_group(name)

### `:\_toggle_interface\_`
Toggling an interface.

    Vedeu.trigger(:_toggle_interface_, name)
    Vedeu.toggle_interface(name)
