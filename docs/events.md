# @title Vedeu Events

# Vedeu Provided Events

Vedeu provides a bunch of events which you can use to control its
behaviour. These are listed below:

## Application Events

### :_goto_
Call a client application controller's action with parameters.

    Vedeu.trigger(:_goto_,
                  :your_controller,
                  :some_action,
                  { id: 7 })
    Vedeu.goto(:your_controller, :some_action, { id: 7 })


## Document Events

### :_editor_execute_

    Vedeu.trigger(:_editor_execute_, name)

### :_editor_delete_character_
This event attempts to delete the character in the named
document at the current virtual cursor position.

    Vedeu.trigger(:_editor_delete_character_, name)

### :_editor_delete_line_
This event attempts to delete the line in the named document
at the current virtual cursor position.

    Vedeu.trigger(:_editor_delete_line_, name)

### :_editor_down_
This event attempts to move the virtual cursor down by one
line in the named document.

    Vedeu.trigger(:_editor_down_, name)

### :_editor_insert_character_
This event attempts to insert the given character in the named
document at the current virtual cursor position.

    Vedeu.trigger(:_editor_insert_character_, name, character)

### :_editor_insert_line_
This event attempts to insert a new line in the named document
at the current virtual cursor position.

    Vedeu.trigger(:_editor_insert_line_, name)

### :_editor_left_
This event attempts to move the virtual cursor left by one
character in the named document.

    Vedeu.trigger(:_editor_left_, name)


### :_editor_right_
This event attempts to move the virtual cursor right by one
character in the named document.

    Vedeu.trigger(:_editor_right_, name)


### :_editor_up_
This event attempts to move the virtual cursor up by one line
in the named document.

    Vedeu.trigger(:_editor_up_, name)


## Focus Events

### :_focus_by_name_
When triggered with an interface name will focus that interface and
restore the cursor position and visibility.

    Vedeu.trigger(:_focus_by_name_, name) # or
    Vedeu.focus_by_name(name)

### :_focus_next_
When triggered will focus the next visible interface and restore the
cursor position and visibility.

    Vedeu.trigger(:_focus_next_) # or
    Vedeu.focus_next

### :_focus_prev_
When triggered will focus the previous visible interface and restore
the cursor position and visibility.

    Vedeu.trigger(:_focus_prev_) # or
    Vedeu.focus_previous


## Refresh Events

### :_refresh_
Refreshes all registered interfaces or the named interface.

The interfaces will be refreshed in z-index order, meaning that
interfaces with a lower z-index will be drawn first. This means
overlapping interfaces will be drawn as specified. Hidden interfaces
will be still refreshed in memory but not shown.

    Vedeu.trigger(:_refresh_)
    Vedeu.trigger(:_refresh_, name)

### :_refresh_cursor_
Will cause the named cursor to refresh, or the cursor of the interface
which is currently in focus.

    Vedeu.trigger(:_refresh_cursor_, name)

### :_refresh_group_
Will cause all interfaces in the named group to refresh.

    Vedeu.trigger(:_refresh_group_, name)

## System Events

### :_cleanup_
Vedeu triggers this event when `:_exit_` is triggered. You can hook
into this to perform a special action before the application
terminates. Saving the user's work, session or preferences might be
popular here.

    Vedeu.trigger(:_exit_)

### :_clear_
Clears the whole terminal space, or when a name is given, the named
interface area will be cleared.

    Vedeu.trigger(:_clear_)
    Vedeu.clear_by_name(name)

### :_command_
Will cause the triggering of the `:command` event; which you should
define to 'do things'.

    Vedeu.trigger(:_command_, command)

### :_editor_
This event is called by {Vedeu::Input::Input#capture}. When
invoked, the key will be passed to the editor for currently
focussed view.

    Vedeu.trigger(:_editor_, key)

### :_exit_
When triggered, Vedeu will trigger a `:cleanup` event which you can
define (to save files, etc) and attempt to exit.

    Vedeu.trigger(:_exit_)
    Vedeu.exit

### :_initialize_
Vedeu triggers this event when it is ready to enter the main loop.
Client applications can listen for this event and perform some
action(s), like render the first screen, interface or make a sound.

    Vedeu.trigger(:_initialize_)

### :_keypress_
Will cause the triggering of the `:key` event; which you should define
to 'do things'. If the `escape` key is pressed, then `key` is triggered
with the argument `:escape`, also an internal event `_mode_switch_` is
triggered. Vedeu recognises most key presses and some 'extended'
keypress (eg. Ctrl+J), a list of supported keypresses can be found here:
{Vedeu::Input::Input#specials} and {Vedeu::Input::Input#f_keys}.

    Vedeu.trigger(:_keypress_, key)

### :_log_
When triggered with a message will cause Vedeu to log the message if
logging is enabled in the configuration.

    Vedeu.trigger(:_log_, message)

### :_maximise_
Maximising an interface.

    Vedeu.trigger(:_maximise_, name)

See {Vedeu::Geometry::Geometry#maximise}

### :_mode_switch_
When triggered (by default, after the user presses `escape`), Vedeu
switches between modes of the terminal. The idea here being
that the raw mode is for single keypress actions, whilst fake and cooked
modes allow the user to enter more elaborate commands- such as commands
with arguments.

    Vedeu.trigger(:_mode_switch_)

### :_resize_
When triggered will cause Vedeu to trigger the `:_clear_` and
`:_refresh_` events. Please see those events for their behaviour.

    Vedeu.trigger(:_resize_)

### :_unmaximise_
Unmaximising an interface.

    Vedeu.trigger(:_unmaximise_, name)

See {Vedeu::Geometry::Geometry#unmaximise}

## DRB Events

### :_drb_input_
Triggering this event will send input to the running application as
long as it has the DRb server running.

    Vedeu.trigger(:_drb_input_, data, type)

### :_drb_retrieve_output_

    Vedeu.trigger(:_drb_retrieve_output_)

### :_drb_store_output_
Triggering this event with 'data' will push data into the running
application's virtual buffer.

    Vedeu.trigger(:_drb_store_output_, data)

### :_drb_restart_
Use the DRb server to request the client application to restart.

    Vedeu.trigger(:_drb_restart_)
    Vedeu.drb_restart

### :_drb_start_
Use the DRb server to request the client application to start.

    Vedeu.trigger(:_drb_start_)
    Vedeu.drb_start

### :_drb_status_
Use the DRb server to request the status of the client application.

    Vedeu.trigger(:_drb_status_)
    Vedeu.drb_status

### :_drb_stop_
Use the DRb server to request the client application to stop.

    Vedeu.trigger(:_drb_stop_)
    Vedeu.drb_stop


## Menu Events

### :_menu_bottom_
Makes the last menu item the current menu item.

    Vedeu.trigger(:_menu_bottom_, name)

### :_menu_current_
Returns the current menu item.

    Vedeu.trigger(:_menu_current_, name)

### :_menu_deselect_
Deselects all menu items.

    Vedeu.trigger(:_menu_deselect_, name)

### :_menu_items_
Returns all the menu items with respective `current` or `selected`
boolean indicators.

    Vedeu.trigger(:_menu_items_, name)

### :_menu_next_
Makes the next menu item the current menu item, until it reaches the
last item.

    Vedeu.trigger(:_menu_next_, name)

### :_menu_prev_
Makes the previous menu item the current menu item, until it reaches
the first item.

    Vedeu.trigger(:_menu_prev_, name)

### :_menu_selected_
Returns the selected menu item.

    Vedeu.trigger(:_menu_selected_, name)

### :_menu_select_
Makes the current menu item also the selected menu item.

    Vedeu.trigger(:_menu_select_, name)

### :_menu_top_
Makes the first menu item the current menu item.

    Vedeu.trigger(:_menu_top_, name)

### :_menu_view_
Returns a subset of the menu items; starting at the current item to
the last item.

    Vedeu.trigger(:_menu_view_, name)


## Movement Events

### :_cursor_origin_
This event moves the cursor to the interface origin; the top left
corner of the named interface.

    Vedeu.trigger(:_cursor_origin_, name)
    Vedeu.trigger(:_cursor_reset_, name)

### :_cursor_position_
When triggered will return the current position of the cursor.

    Vedeu.trigger(:_cursor_position_, name)

### :_cursor_reposition_
Moves the cursor to a relative position inside the interface.

    Vedeu.trigger(:_cursor_reposition_, name, y, x)

### :_cursor_(up, down, left, right)_
Adjusts the position of the cursor or view.

When a name is not given, the cursor in the interface which is
currently in focus should move in the direction specified.

    Vedeu.trigger(:_cursor_down_)
    Vedeu.trigger(:_cursor_left_)
    Vedeu.trigger(:_cursor_left_, 'my_interface')
    Vedeu.trigger(:_cursor_right_)
    Vedeu.trigger(:_cursor_up_)

- The cursor or view may not be visible, but it will still move if
  requested.
- The cursor will not exceed the border or boundary of the interface,
  or boundary of the visible terminal.
- The cursor will move freely within the bounds of the interface,
  irrespective of content.
- The view will not exceed the boundary of the visible terminal,
  though its offset may (this means content will appear to have
  scrolled).
- The view will move freely within the bounds of the interface,
  irrespective of content.

### :_view_(up, down, left, right)_

See {file:docs/events.md#\_cursor__up_down_left_right_}

    Vedeu.trigger(:_view_down_,  'my_interface')
    Vedeu.trigger(:_view_left_,  'my_interface')
    Vedeu.trigger(:_view_right_, 'my_interface')
    Vedeu.trigger(:_view_up_,    'my_interface')

Each of the :_view_* events has an alias, :_geometry_* if you prefer.

## Visibility Events

### :_clear_group_
Clears the spaces occupied by the interfaces belonging to the named
group.

    Vedeu.trigger(:_clear_group_, name)
    Vedeu.clear_by_group(name)

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
Hiding an interface.

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
Showing an interface.

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

# Vedeu Custom Events

You can bind or unbind your own events using Vedeu's event system. It
provides:

### Vedeu.bind
### Vedeu.bind_alias
### Vedeu.trigger
### Vedeu.unbind
### Vedeu.unbind_alias
