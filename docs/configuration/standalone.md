Sets boolean to prevent user intervention. This is the same as setting
{Vedeu::Config::API#interactive} to false.

    # Same as `standalone true` or `interactive false`.
    Vedeu.configure do
      standalone!
      # ...
    end

    # => Disallow user input.
    Vedeu.configure do
      standalone true
      # ...
    end

    # => Allow user input.
    Vedeu.configure do
      standalone false
      # ...
    end
