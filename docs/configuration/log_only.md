Only log specific message types. A complete list of message types can
be found at {Vedeu::Configuration.log_types}.

    Vedeu.configure do
      log_only :debug, :event

      # or
      log_only [:debug, :info]

      # ...
    end
