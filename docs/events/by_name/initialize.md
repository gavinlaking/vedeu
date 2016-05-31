### `:_initialize_`

Vedeu triggers this event when it is ready to enter the main loop.
Client applications can listen for this event and perform some
action(s), like render the first screen, interface or make a sound.

    Vedeu.trigger(:_initialize_)
