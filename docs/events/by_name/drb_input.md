### `:_drb_input_`

Triggering this event will send input to the running application as
long as it has the DRb server running.

Note: See {Vedeu::Distributed::Server#input} for parameter details.

    Vedeu.trigger(:_drb_input_, data, type)
