Compression reduces the number of escape sequences being sent to the
terminal which improves redraw/render/refresh rate. By default it is
enabled.

Sets boolean to enable/disable compression. Vedeu's default setting is
for compression to be enabled. Setting `compression` to false will
disable compression.

    # Set:
    Vedeu.configure do
      compression! # enabled (default)
      # ...
    end

    Vedeu.configure do
      compression false
      # ...
    end

    # Get:
    Vedeu.config.compression

Note:

- Be aware that running an application without compression will affect
  performance.
