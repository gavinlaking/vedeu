Sets boolean to enable/disable debugging. Vedeu's default setting is
for debugging to be disabled. Using `debug!` or setting `debug` to
true will enable debugging.

Enabling debugging will:
- Log when an event is triggered which has no action registered.
- Enable `Vedeu::Logging::Timer` meaning various timing information is
  output to the log file.
- Produce a full a backtrace to STDOUT and the log file upon
  unrecoverable error or unhandled exception.

    # Set:
    Vedeu.configure do
      debug!
      # ...
    end

    Vedeu.configure do
      debug false
      # ...
    end

    # Get:
    Vedeu.config.debug?
    Vedeu.config.debug
