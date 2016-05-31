Instructs Vedeu to use threads to perform certain actions.

This can have a performance impact.

    # Set:
    Vedeu.configure do
      threaded false
      # ...
    end

    # Get:
    Vedeu.config.threaded?
    Vedeu.config.threaded
