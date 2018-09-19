# @title Vedeu Keymaps
# Vedeu Keymaps

Keymaps define the keypresses applicable to an interface or view. A
keymap sharing the same name as an interface will only operate if that
interface is currently in focus.

Alongside this functioanlity, there is a global keymap '_global_'
which will respond to keypresses regardless of which interface is in
focus. The global keymap is useful for mapping the key to exit the
application for example.

- It has a name. This name associates it with an
  {file:docs/interfaces.md Interface}.
- A key registered with a keymap can call a method or trigger an
  event, or either, in multitude.
- Keymaps only affect the interface/view with the same name.
- The same key can be registered with mulitple keymaps and perform
  different actions dependent on which interface is currently in
  focus.
- Some keys on the keymap are stored as strings, whilst others are
  symbols; representations of the keys pressed.

You can find out which keys Vedeu recognises here:
{Vedeu::Input::Translator}.
