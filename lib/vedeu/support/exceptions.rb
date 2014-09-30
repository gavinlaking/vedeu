module Vedeu

  # Raised when Vedeu attempts to access a named buffer that does not exist.
  BufferNotFound = Class.new(StandardError)

  # Raised when a cursor cannot be found by name.
  CursorNotFound = Class.new(StandardError)

  # Raised when trying to access a group of interfaces which do not exist by
  # this name.
  GroupNotFound = Class.new(StandardError)

  # Raised when an interface cannot be found by name.
  InterfaceNotFound = Class.new(StandardError)

  # Raised when the value for a height is less than 0 or nil.
  # @see Vedeu::Area#new
  InvalidHeight = Class.new(StandardError)

  # Raised when Vedeu attempts to parse a {Vedeu.view} or {Vedeu.interface} and
  # encounters a problem.
  InvalidSyntax = Class.new(StandardError)

  # Raised when the value for a width is less than 0 or nil.
  # @see Vedeu::Area#new
  InvalidWidth = Class.new(StandardError)

  # Raised when attempting to assign a key which is already in use.
  KeyInUse = Class.new(StandardError)

  # Raised when a menu cannot be found by name.
  MenuNotFound = Class.new(StandardError)

  # Raised when the attributes argument to {Vedeu::Registrar} does not contain
  # a required key or the value to that key is nil or empty.
  MissingRequired = Class.new(StandardError)

  # Raised intentionally when the client application wishes to switch between
  # cooked and raw (or vice versa) terminal modes. Vedeu is hard-wired to use
  # the `Escape` key to trigger this change for the time being.
  ModeSwitch = Class.new(StandardError)

  # Raised when attempting to reach the currently in focus interface, when no
  # interfaces have been defined yet.
  NoInterfacesDefined = Class.new(StandardError)

  # Raised to remind me (or client application developers) that the subclass
  # implements the functionality sought.
  NotImplemented = Class.new(StandardError)

  # Raised when trying to access an interface column less than 1 or greater
  # than 12. Vedeu is hard-wired to a 12-column layout for the time being.
  OutOfRange = Class.new(StandardError)

end # Vedeu
