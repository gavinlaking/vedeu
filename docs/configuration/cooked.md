Sets the terminal mode to `cooked`. Default terminal mode is `raw`.
Also, see {Vedeu::Config::API#raw!}

    # Set:
    Vedeu.configure do
      cooked!
      # ...
    end

    # Get:
    Vedeu.config.terminal_mode
