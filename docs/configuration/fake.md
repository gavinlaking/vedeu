Sets the terminal mode to `fake`. Default terminal mode is `raw`.

    # Set:
    Vedeu.configure do
      fake!
      # ...
    end

    # Get:
    Vedeu.config.terminal_mode
