Sets boolean to enable/disable mouse support.

    # Set:
    Vedeu.configure do
      mouse! # => same as `mouse true`

      # or...
      mouse true

      mouse false

      # ...
    end

    # Get:
    Vedeu.config.mouse?
    Vedeu.config.mouse
