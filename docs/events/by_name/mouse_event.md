Triggered when Vedeu receives input from a mouse.

Binding to this event in the client application will give access to
the escape sequence emitted by the terminal.

    Vedeu.bind(:_mouse_event_) do |input|
      # ... some code ...
    end
