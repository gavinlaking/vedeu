### Vedeu.render_output

When the given output is an escape sequence, it is directly written to
the terminal, bypassing the buffer. Otherwise, it is written to the
terminal buffer, and then the terminal buffer is refreshed.

    Vedeu.render_output(output)
