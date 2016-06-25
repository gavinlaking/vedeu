### `:_cleanup_`

Vedeu triggers this event when `:_exit_` is triggered. You can hook
into this to perform a special action before the application
terminates. Saving the user's work, session or preferences might be
popular here.

    Vedeu.trigger(:_exit_)
