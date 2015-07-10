# @title Menu Events

## Menu Events

### Bottom Item

    Vedeu.trigger(:_menu_bottom_, name)

Makes the last menu item the current menu item.


### Current Item

    Vedeu.trigger(:_menu_current_, name)

Returns the current menu item.


### Deselect All

    Vedeu.trigger(:_menu_deselect_, name)

Deselects all menu items.


### All Items

    Vedeu.trigger(:_menu_items_, name)

Returns all the menu items with respective `current` or `selected` boolean indicators.


### Next Item

    Vedeu.trigger(:_menu_next_, name)

Makes the next menu item the current menu item, until it reaches the last item.


### Previous Item

    Vedeu.trigger(:_menu_prev_, name)

Makes the previous menu item the current menu item, until it reaches the first item.


### Selected Item

    Vedeu.trigger(:_menu_selected_, name)

Returns the selected menu item.


### Select Current Item

    Vedeu.trigger(:_menu_select_, name)

Makes the current menu item also the selected menu item.


### Top Item

    Vedeu.trigger(:_menu_top_, name)

Makes the first menu item the current menu item.


### View from ...

    Vedeu.trigger(:_menu_view_, name)

Returns a subset of the menu items; starting at the current item to the last item.
