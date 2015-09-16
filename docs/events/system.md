# @title Vedeu System Events

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
