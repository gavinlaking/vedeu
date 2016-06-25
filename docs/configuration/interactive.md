Sets boolean to allow user input. The default behaviour of Vedeu is to
be interactive. This is the same as setting
{Vedeu::Config::API#standalone} to false.

    # Set:
    # same as `interactive true` or `standalone false`.
    Vedeu.configure do
      interactive!
      # ...
    end

    # => Allow user input.
    Vedeu.configure do
      interactive true
      # ...
    end

    # => Disallow user input.
    Vedeu.configure do
      interactive false
      # ...
    end

    # Get:
    Vedeu.config.interactive?
    Vedeu.config.interactive
