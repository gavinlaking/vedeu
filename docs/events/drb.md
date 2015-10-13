# @title Vedeu DRb Events

## DRB Events

### `:\_drb_input\_`
Triggering this event will send input to the running application as
long as it has the DRb server running.

Note: See {Vedeu::Distributed::Server#input} for parameter details.

    Vedeu.trigger(:_drb_input_, data, type)

### `:\_drb_retrieve_output\_`

    Vedeu.trigger(:_drb_retrieve_output_)

### `:\_drb_store_output\_`
Triggering this event with 'data' will push data into the running
application's virtual buffer.

Note: See {Vedeu::Terminal::Buffer#write} for parameter details.

    Vedeu.trigger(:_drb_store_output_, data)

### `:\_drb_restart\_`
Use the DRb server to request the client application to restart.

    Vedeu.trigger(:_drb_restart_)
    Vedeu.drb_restart

### `:\_drb_start\_`
Use the DRb server to request the client application to start.

    Vedeu.trigger(:_drb_start_)
    Vedeu.drb_start

### `:\_drb_status\_`
Use the DRb server to request the status of the client application.

    Vedeu.trigger(:_drb_status_)
    Vedeu.drb_status

### `:\_drb_stop\_`
Use the DRb server to request the client application to stop.

    Vedeu.trigger(:_drb_stop_)
    Vedeu.drb_stop
