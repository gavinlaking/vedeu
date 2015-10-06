# @title Vedeu Movement Events

## Movement Events

Note: 'name' is a Symbol unless mentioned otherwise.

For cursor related movement events, please refer to
{file:docs/cursor.md} Cursors.


### :\_view_(up, down, left, right)_

Please note that the name of the view is required for these events.

    Vedeu.trigger(:_view_down_, name)
    Vedeu.trigger(:_view_left_, name)
    Vedeu.trigger(:_view_right_, name)
    Vedeu.trigger(:_view_up_, name)

Each of the :\_view_* events has an alias, :\_geometry_* if you prefer.
