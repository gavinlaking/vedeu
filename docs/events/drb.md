# @title DRB Events

## DRB Events

### Start DRB Server

    Vedeu.trigger(:_drb_start_)

Use the DRb server to request the client application to start.


### Restart DRB Server

    Vedeu.trigger(:_drb_restart_)

Use the DRb server to request the client application to restart.


### Stop DRB Server

    Vedeu.trigger(:_drb_stop_)

Use the DRb server to request the client application to stop.


### DRB Status

    Vedeu.trigger(:_drb_status_)

Use the DRb server to request the status of the client application.


### Store Output of DRB Server

    Vedeu.trigger(:_drb_store_output_, data)

Triggering this event with 'data' will push data into the running application's virtual buffer.


### Retrieve Output of DRB Server

    Vedeu.trigger(:_drb_retrieve_output_)


### Send Input to DRB Server

    Vedeu.trigger(:_drb_input_, data, type)

Triggering this event will send input to the running application as long as it has the DRb server running.
