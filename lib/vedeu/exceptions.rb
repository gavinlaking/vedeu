module Vedeu

  # Raised with Vedeu attempts to access a client application controller that
  # does not exist.
  #
  class ControllerNotFound < StandardError

  end # ControllerNotFound

  # Raised with Vedeu attempts to access a client application controller's
  # action that does not exist.
  #
  class ActionNotFound < StandardError

  end # ActionNotFound

  # Raised with Vedeu attempts to access a named model that does not exist.
  #
  class ModelNotFound < StandardError

  end # ModeSwitch

  # Raised when Vedeu attempts to parse a {Vedeu.view} or {Vedeu.interface} and
  # encounters a problem.
  #
  class InvalidSyntax < StandardError

  end # InvalidSyntax

  # Raised when a name is not provided for a model when attempting to store it
  # in a repository.
  #
  class MissingRequired < StandardError

  end # MissingRequired

  # Raised intentionally when the client application wishes to switch between
  # cooked, fake and raw terminal modes.
  #
  # @see Vedeu::Application
  #
  class ModeSwitch < StandardError

  end # ModeSwitch

  # Raised to remind me (or client application developers) that the subclass
  # implements the functionality sought.
  #
  # @see Vedeu::ColourTranslator
  #
  class NotImplemented < StandardError

  end # NotImplemented

  # Raised when trying to access an interface column less than 1 or greater
  # than 12. Vedeu is hard-wired to a 12-column layout for the time being.
  #
  # @see Vedeu::Grid
  #
  class OutOfRange < StandardError

  end # OutOfRange

  # Raised when Vedeu encounters an error.
  #
  class VedeuError < StandardError

  end # VedeuError,

  # Raised when Vedeu wishes to exit.
  #
  # @see Vedeu::MainLoop
  #
  class VedeuInterrupt < StandardError

  end # VedeuInterrupt

end # Vedeu
