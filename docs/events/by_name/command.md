### `:_command_`

This event is used by Vedeu internally, though you can bind to it if
you wish. It is preferred for you to bind to `:command` though.

Will cause the triggering of the `:command` event; which you should
define to 'do things'.

    Vedeu.trigger(:_command_, command)

    Vedeu.bind(:command) do
      # ... your code here ...
    end

Alternatively, you can access commands entered using the following
API methods: (See {Vedeu::Input::Store} for more details).

    Vedeu.all_commands

    Vedeu.last_command
