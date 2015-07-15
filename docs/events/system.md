# @title System Events

## System Events

### Exiting Vedeu

    `Vedeu.trigger(:_exit_)`

When triggered, Vedeu will trigger a `:cleanup` event which you can define (to save files, etc) and attempt to exit. Also available as: `Vedeu.exit`.


### Pressing a key

    `Vedeu.trigger(:_keypress_, key)`

Will cause the triggering of the `:key` event; which you should define to 'do things'. If the `escape` key is pressed, then `key` is triggered with the argument `:escape`, also an internal event `_mode_switch_` is triggered. Vedeu recognises most key presses and some 'extended' keypress (eg. Ctrl+J), a list of
the supported keypresses can be found here: {Vedeu::Input#specials} and {Vedeu::Input#f_keys}.


### Sending a command

    `Vedeu.trigger(:_command_)`

Will cause the triggering of the `:command` event; which you should define to 'do things'.


### Logging to the log file

    `Vedeu.trigger(:_log_, message)`

When triggered with a message will cause Vedeu to log the message if logging is enabled in the configuration.


### Focussing an interface by name

    `Vedeu.trigger(:_focus_by_name_, name)`

When triggered with an interface name will focus that interface and restore the cursor position and visibility.


### Focussing the next visible interface

    `Vedeu.trigger(:_focus_next_)`

When triggered will focus the next interface and restore the cursor position and visibility.


### Focussing the previous visible interface

    `Vedeu.trigger(:_focus_prev_)`

When triggered will focus the previous interface and restore the cursor position and visibility.


### Clearing the terminal

    `Vedeu.trigger(:_clear_)`

Clears the whole terminal space, or the named interface area to be cleared if given. Also available as: `Vedeu.clear_by_name(name)`.


### Refreshing all interfaces

    `Vedeu.trigger(:_refresh_)`

Will cause all interfaces to refresh. Note: Hidden interfaces will be still refreshed in memory but not shown.


### Refresing an interface by name

    `Vedeu.trigger(:_refresh_, name)`

Will cause the named interface to refresh. Note: Hidden interfaces will be still refreshed in memory but not shown.


### Refreshing the cursor

    `Vedeu.trigger(:_refresh_cursor_, name)`

Will cause the named cursor to refresh, or the cursor of the interface which is currently in focus.


### Refreshing a group of interfaces

    `Vedeu.trigger(:_refresh_group_, name)`

Will cause all interfaces in the named group to refresh.


### Clearing a group

    `Vedeu.trigger(:_clear_group_, name)`

Clears the spaces occupied by the interfaces belonging to the named group. Also available as: `Vedeu.clear_by_group(name)`


### Maximising an interface

    `Vedeu.trigger(:_maximise_, name)`

See also: {Vedeu::Geometry#maximise}


### Unmaximising an interface

    `Vedeu.trigger(:_unmaximise_, name)`

See also: {Vedeu::Geometry#unmaximise}

