# @title Vedeu Focus Events

## Focus Events

### :_focus_by_name_
When triggered with an interface name will focus that interface and
restore the cursor position and visibility.

    Vedeu.trigger(:_focus_by_name_, name) # or
    Vedeu.focus_by_name(name)

### :_focus_next_
When triggered will focus the next visible interface and restore the
cursor position and visibility.

    Vedeu.trigger(:_focus_next_) # or
    Vedeu.focus_next

### :_focus_prev_
When triggered will focus the previous visible interface and restore
the cursor position and visibility.

    Vedeu.trigger(:_focus_prev_) # or
    Vedeu.focus_previous
