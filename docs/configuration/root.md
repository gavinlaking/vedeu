Configure the root class of the client application.

Vedeu will execute this controller with action and optional arguments
first.

    # Set:
    Vedeu.configure do
      root :controller, :action, args
      # ...
    end

    # Get:
    Vedeu.config.root
