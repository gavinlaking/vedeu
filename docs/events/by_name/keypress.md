### `:_keypress_`

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
