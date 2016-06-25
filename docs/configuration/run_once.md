Sets boolean to run the Vedeu main application loop once. In effect,
using `run_once!` or setting `run_once` to true will allow Vedeu to
initialize, run any client application code, cleanup, then terminate.

    # Set:
    Vedeu.configure do
      run_once!
      # ...
    end

    # Get:
    Vedeu.config.run_once
