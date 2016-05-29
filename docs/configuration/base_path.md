Configure the base path of the client application.

Override the base path for the application (for locating
templates and other resources). By default the base path is
just the current working directory but this will not work for many
applications.

    # Set:
    Vedeu.configure do
      base_path '/path/to/application'
      # ...
    end

    # Get:
    Vedeu.config.base_path
