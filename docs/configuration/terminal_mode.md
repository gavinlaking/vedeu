Sets the terminal mode. Valid values can be either ':cooked', ':fake'
or :raw'.

    Vedeu.configure do
      terminal_mode :cooked

      # or...

      terminal_mode :fake

      # or...

      terminal_mode :raw

      # or...

      terminal_mode = :raw
      terminal_mode = :fake
      terminal_mode = :cooked

      # ... some code
    end

