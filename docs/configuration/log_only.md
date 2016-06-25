Only log specific message types. A complete list of message types can
be found at {Vedeu::LOG_TYPES}.

    # Set:
    Vedeu.configure do
      log_only :debug, :event

      # or
      log_only [:debug, :info]

      # ...
    end

    # Get:
    Vedeu.config.log_only
