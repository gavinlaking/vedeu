### `:_mode_switch_`

When triggered, Vedeu switches between modes of the terminal. The idea
here being that the raw mode is for single keypress actions, whilst
fake and cooked modes allow the user to enter more elaborate commands-
such as commands with arguments.

    Vedeu.trigger(:_mode_switch_, mode)
