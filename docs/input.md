# @title Vedeu Input
# Vedeu Input

A configured and running client application using Vedeu will spend the
majority of its time waiting for input from the terminal by the user.

Input in to Vedeu is essentially characters derived from a keypress or
keypresses, and throughout this document, 'characters' and
'keypresses' may be used interchangably to mean 'input'.

* It should be noted that data can be also be 'piped' into a Vedeu
application as input, though at this time, this is not the mode du
jour.

The input received by Vedeu is handled in one of three ways, depending
on which mode Vedeu has been configured to use;
'{file:docs/input.md#label-Raw+Mode raw}' (default),
'{file:docs/input.md#label-Cooked+Mode cooked}' or
'{file:docs/input.md#label-Fake+Mode fake}'. See below for details of
each.

* Vedeu uses Ruby's 'IO/Console' from the standard library to
facilitate this. For more information relating to this area, consult
the Ruby documentation, or the 'stty(1)' or 'termios(3)' manpages.

## Raw Mode

This is the default mode for Vedeu. Keypresses or characters are not
processed by the underlying terminal, but instead sent directly to
Vedeu to be handled.

    Vedeu.configure do
      terminal_mode :raw

      # or...

      raw!

      # ...more configuration here
    end

This mode is generally used to perform an operation dependent on the
key which was pressed. The configuration of mapping keypresses to
actions is handled on a per-interface basis; each interface having its
own keymap which can perform specific actions.

There is also global keymap available to handle certain keypresses
application-wide, ie. irrespective of the interface or view which is
currently in focus. The global keymap would specify the keypress
needed to exit the application, for example.

See {file:docs/keymaps.md Keymaps} for more information.

## Cooked Mode

Here, the input from the user is stored in an internal buffer by the
terminal itself until a line-feed or carriage-return character is
encountered. The terminal then sends this stream of characters to
Vedeu to be processed.

    Vedeu.configure do
      terminal_mode :cooked

      # or...

      cooked!

      # ...more configuration here
    end

## Fake Mode

Whilst technically the terminal will be in raw mode, with the 'fake'
mode, Vedeu attempts to simulate cooked mode but with some additional
functionality. To do this, Vedeu creates an internal buffer for
characters resulting from keypresses to be either stored or processed
immediately.

    Vedeu.configure do
      terminal_mode :fake

      # or...

      fake!

      # ...more configuration here
    end

## Mode Switching

During the lifecycle of a Vedeu client application it may be necessary
to switch between the different modes offered. This is handled by
triggering the `:\_mode_switch\_` event. By default, this cycles
through the available modes. When an optional but valid target mode is
given, that mode will be activated instead.

    Vedeu.trigger(:_mode_switch_, mode) # Valid values for mode are
                                        # :raw, :cooked or :fake

## Accessing Input

Accessing the input can be achieved in the following ways:

- Via a keymap: Vedeu will interpret the input and trigger events or
  call methods based on the input received.

- Via API calls: You can access that which is entered into the client
  application with the following methods:

        Vedeu.all_commands   # => Returns an array of all the commands
                             #    entered.
        Vedeu.last_command   # => Returns the last command entered.
        Vedeu.all_keypresses # => Returns all the individual
                             #    keypresses entered as an array.
        Vedeu.last_keypress  # => Returns the last keypress entered.

- Via events: You can access that which is entered by binding to
  events which Vedeu will trigger as input is received:

        Vedeu.bind(:key) do
          # ... do something with the key
        end

        Vedeu.bind(:command) do
          # ... do something with the command
        end
