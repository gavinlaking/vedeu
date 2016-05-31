Sets the location of the log file, or disables the log. By default,
the log file is set to '/tmp/vedeu_bootstrap.log'. Note: On Windows
systems, the log directory is determined by the output from
`Dir.tmpdir`.

    # Set:
    # Log messages will be sent to the path given.
    Vedeu.configure do
      log '/var/log/vedeu.log'
      # ...
    end

    # Log messages will be silently dropped.
    Vedeu.configure do
      log false
      # ...
    end

    # Get:
    Vedeu.config.log? # Returns whether logging is enabled
    Vedeu.config.log  # Returns the configured log file.
