Sets the colour mode of the terminal.

    # Set:
    Vedeu.configure do
      colour_mode 256
      # ...
    end

    # Get:
    Vedeu.config.colour_mode

Note
- iTerm 2 on Mac OSX will handle the true colour setting
  (16777216), whereas Terminator on Linux will not display
  colours correctly. For compatibility across platforms, it is
  recommended to either not set the colour mode at all and
  allow it to be detected, or use 256 here.
