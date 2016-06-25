### `:_editor_`

This event is called by {Vedeu::Input::Capture#read}. When
invoked, the key will be passed to the editor for currently
focussed view.

Note: 'key' is a String for alphanumeric keys and special keys are
represented by Symbols.

    Vedeu.trigger(:_editor_, key)
