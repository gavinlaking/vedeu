# @title Vedeu Menu Events

## Menu Events

Note: 'name' is a Symbol unless mentioned otherwise.

### `:\_menu_bottom\_`
Makes the last menu item the current menu item.

    Vedeu.trigger(:_menu_bottom_, name)

### `:\_menu_current\_`
Returns the current menu item.

    Vedeu.trigger(:_menu_current_, name)

### `:\_menu_deselect\_`
Deselects all menu items.

    Vedeu.trigger(:_menu_deselect_, name)

### `:\_menu_items\_`
Returns all the menu items with respective `current` or `selected`
boolean indicators.

    Vedeu.trigger(:_menu_items_, name)

### `:\_menu_next\_`
Makes the next menu item the current menu item, until it reaches the
last item.

    Vedeu.trigger(:_menu_next_, name)

### `:\_menu_prev\_`
Makes the previous menu item the current menu item, until it reaches
the first item.

    Vedeu.trigger(:_menu_prev_, name)

### `:\_menu_selected\_`
Returns the selected menu item.

    Vedeu.trigger(:_menu_selected_, name)

### `:\_menu_select\_`
Makes the current menu item also the selected menu item.

    Vedeu.trigger(:_menu_select_, name)

### `:\_menu_top\_`
Makes the first menu item the current menu item.

    Vedeu.trigger(:_menu_top_, name)

### `:\_menu_view\_`
Returns a subset of the menu items; starting at the current item to
the last item.

    Vedeu.trigger(:_menu_view_, name)
