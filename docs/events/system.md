# @title Vedeu System Events

## System Events

### `:\_cleanup\_`
Vedeu triggers this event when `:_exit_` is triggered. You can hook
into this to perform a special action before the application
terminates. Saving the user's work, session or preferences might be
popular here.

    Vedeu.trigger(:_exit_)

### `:\_command\_`
This event is used by Vedeu internally, though you can bind to it if
you wish. It is preferred for you to bind to `:command` though.

Will cause the triggering of the `:command` event; which you should
define to 'do things'.

    Vedeu.trigger(:_command_, command)

    Vedeu.bind(:command) do
      # ... your code here ...
    end

Alternatively, you can access commands entered using the following
API methods: (See {Vedeu::Input::Store} for more details).

    Vedeu.all_commands

    Vedeu.last_command

### `:\_editor\_`
This event is called by {Vedeu::Input::Capture#read}. When
invoked, the key will be passed to the editor for currently
focussed view.

Note: 'key' is a String for alphanumeric keys and special keys are
represented by Symbols.

    Vedeu.trigger(:_editor_, key)

### `:\_exit\_`
When triggered, Vedeu will trigger a `:cleanup` event which you can
define (to save files, etc) and attempt to exit.

    Vedeu.trigger(:_exit_)
    Vedeu.exit

### `:\_initialize\_`
Vedeu triggers this event when it is ready to enter the main loop.
Client applications can listen for this event and perform some
action(s), like render the first screen, interface or make a sound.

    Vedeu.trigger(:_initialize_)

### `:\_keypress\_`
This event is used by Vedeu internally, though you can bind to it if
you wish. It is preferred for you to bind to `:key` though.

When the name is given:

- The given key is passed to the named keymap. If the keymap is
  registered, and the key has an associated action assigned, then
  the action will be called/triggered.
- If the keymap is not registered, the key will be passed to the
  global keymap to be actioned, or ignored if the global keymap does
  not have an action assigned for the key pressed.

When the name is not given:

- The given key is passed to the named keymap associated with the
  interface/view currently in focus. If the key has an associated
  action assigned, then the action will be called or triggered,
  otherwise, the key is (as above) passed to the global keymap to be
  processed.

It is also to be noted, that a `:key` event will be triggered
irrespective of the conditions above, you can bind to this event
separately to 'do things'.

    Vedeu.bind(:key) do
      # ... your code here ...
    end

Alternatively, you can access keypresses entered using the following
API methods: (See {Vedeu::Input::Store} for more details).

    Vedeu.all_keypresses

    Vedeu.last_keypress

A list of supported keypresses can be found here:
{Vedeu::Input::Capture}.

    Vedeu.trigger(:_keypress_, key, optional_name)

### `:\_log\_`
When triggered with a message will cause Vedeu to log the message if
logging is enabled in the configuration.

Note: 'message' is a String.

    Vedeu.trigger(:_log_, message)

### `:\_mode_switch\_`
When triggered, Vedeu switches between modes of the terminal. The idea
here being that the raw mode is for single keypress actions, whilst
fake and cooked modes allow the user to enter more elaborate commands-
such as commands with arguments.

    Vedeu.trigger(:_mode_switch_, mode)
