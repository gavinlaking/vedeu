### Vedeu.direct_write

Write the given output directly to the configured or default
renderers. Using this method will not write the output to the terminal
buffer. It is used mainly for sending individual escape sequences to
the terminal- such as those which hide and show the cursor.

    Vedeu.direct_write(output)
