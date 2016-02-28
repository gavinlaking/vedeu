Configure the root class of the client application.

Vedeu will execute this controller with action and optional arguments
first.

    Vedeu.configure do
      root :controller, :action, args
      # ...
    end
