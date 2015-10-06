# @title Vedeu System Events

## System Events

### :\_cleanup_
Vedeu triggers this event when `:_exit_` is triggered. You can hook
into this to perform a special action before the application
terminates. Saving the user's work, session or preferences might be
popular here.

    Vedeu.trigger(:_exit_)

### :\_command_
Will cause the triggering of the `:command` event; which you should
define to 'do things'.

    Vedeu.trigger(:_command_, command)

### :\_editor_
This event is called by {Vedeu::Input::Capture#read}. When
invoked, the key will be passed to the editor for currently
focussed view.

Note: 'key' is a String for alphanumeric keys and special keys are
represented by Symbols.

    Vedeu.trigger(:_editor_, key)

### :\_exit_
When triggered, Vedeu will trigger a `:cleanup` event which you can
define (to save files, etc) and attempt to exit.

    Vedeu.trigger(:_exit_)
    Vedeu.exit

### :\_initialize_
Vedeu triggers this event when it is ready to enter the main loop.
Client applications can listen for this event and perform some
action(s), like render the first screen, interface or make a sound.

    Vedeu.trigger(:_initialize_)

### :\_keypress_
Will cause the triggering of the `:key` event; which you should define
to 'do things'. If the `escape` key is pressed, then `key` is
triggered with the argument `:escape`, also an internal event
`_mode_switch_` is triggered. Vedeu recognises most key presses and
some 'extended' keypress (eg. Ctrl+J), a list of supported keypresses
can be found here: {Vedeu::Input::Capture}.

    Vedeu.trigger(:_keypress_, key)

### :\_log_
When triggered with a message will cause Vedeu to log the message if
logging is enabled in the configuration.

Note: 'message' is a String.

    Vedeu.trigger(:_log_, message)

### :\_mode_switch_
When triggered (by default, after the user presses `escape`), Vedeu
switches between modes of the terminal. The idea here being
that the raw mode is for single keypress actions, whilst fake and
cooked modes allow the user to enter more elaborate commands- such as
commands with arguments.

    Vedeu.trigger(:_mode_switch_)
