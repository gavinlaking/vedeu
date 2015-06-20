## Getting Started with Vedeu

- Set your configuration.
- Define your interfaces.
  - Define the border.
  - Define the geometry.
  - Define the keymap.
- Define the global keymap, this will be used irrespective of the interface
  currently in focus.


### Predefined Keys

Vedeu automatically defines four keys for your client application:

  - q = Quit. Internally triggers the :_exit_ system event which in turn
    requests the application stops. This triggers the event :cleanup which
    the client application can bind to and perform any tidying up it wishes
    to perform before exiting.

  - <esc> = Mode Switch. Toggle between cooked and raw terminal modes.

  - <tab> = Focus Next. Focus the next interface in the focus list.

  - <shift+tab> = Focus Previous. Focus the previous interface in the focus
    list.

