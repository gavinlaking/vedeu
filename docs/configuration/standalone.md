Sets boolean to prevent user intervention. This is the same as setting
{Vedeu::Config::API#interactive} to false.

    # Set:
    Vedeu.configure do
      standalone! # Same as `standalone true` or `interactive false`.
      # ...
    end

    Vedeu.configure do
      standalone true # Disallow user input.
      # ...
    end

    Vedeu.configure do
      standalone false # Allow user input.
      # ...
    end

    # Get:
    Vedeu.config.standalone
