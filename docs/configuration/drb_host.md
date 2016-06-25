Sets the hostname or IP address of the DRb server.

    # Set:
    Vedeu.configure do
      drb_host 'localhost'
      # ...
    end

    # Get:
    Vedeu.config.drb_host
