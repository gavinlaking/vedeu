Sets the value of STDIN.

    # Set:
    Vedeu.configure do
      stdin IO.console
      # ...
    end

    # Get:
    Vedeu.config.stdin
