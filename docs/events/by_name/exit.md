### `:_exit_`

When triggered, Vedeu will trigger a `:cleanup` event which you can
define (to save files, etc) and attempt to exit.

    Vedeu.trigger(:_exit_)
    Vedeu.exit
