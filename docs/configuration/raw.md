Sets the terminal mode to `raw`. Default terminal mode is `raw`. Also,
see {Vedeu::Config::API#cooked!}

    # Set:
    Vedeu.configure do
      raw!
      # ...
    end

    # Get:
    Vedeu.config.terminal_mode
