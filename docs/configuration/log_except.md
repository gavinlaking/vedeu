Log specific message types except those given. A complete list of
message types can be found at {Vedeu::Configuration.log_types}.

    Vedeu.configure do
      log_except :debug, :event

      # or
      log_except [:debug, :info]

      # ...
    end
