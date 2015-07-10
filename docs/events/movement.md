# @title Movement Events

## Movement Events

### Moving the cursor

We can move the cursor by name using the events listed below:

#### Moving the cursor down

    Vedeu.trigger(:_cursor_down_, name)

See also: {Vedeu::Move}


#### Moving the cursor left

    Vedeu.trigger(:_cursor_left_, name)

See also: {Vedeu::Move}


#### Resetting the position of the cursor

    Vedeu.trigger(:_cursor_origin_, name)
    Vedeu.trigger(:_cursor_reset_, name)

This event moves the cursor to the interface origin; the top left corner of the named interface. See also: {Vedeu::Move}


#### Fetching the position of the cursor

    Vedeu.trigger(:_cursor_position_, name)

When triggered will return the current position of the cursor. See also: {Vedeu::Move}



#### Moving the cursor to an arbitrary position

    Vedeu.trigger(:_cursor_reposition_, name, y, x)

Moves the cursor to a relative position inside the interface. See also: {Vedeu::Move}


#### Moving the cursor right

    Vedeu.trigger(:_cursor_right_, name)

See also: {Vedeu::Move}


#### Moving the cursor up

    Vedeu.trigger(:_cursor_up_, name)

See also: {Vedeu::Move}


### Moving the interface

We can move an interface by altering its geometry. This is performed using the events listed below:

### Moving the interface down

    Vedeu.trigger(:_geometry_down_, name)

See also: {Vedeu::Move}


### Moving the interface left

    Vedeu.trigger(:_geometry_left_, name)

See also: {Vedeu::Move}


### Moving the interface right

    Vedeu.trigger(:_geometry_right_, name)

See also: {Vedeu::Move}


### Moving the interface up

    Vedeu.trigger(:_geometry_up_, name)

See also: {Vedeu::Move}




### Showing an interface

    Vedeu.trigger(:_show_interface_, name)

See: {Vedeu::Buffer#show}


### Toggling an interface

    Vedeu.trigger(:_toggle_interface_, name)

See: {Vedeu::Buffer#toggle}
