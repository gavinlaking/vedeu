module Vedeu

  # Raised with Vedeu attempts to access a named model that does not exist.
  #
  # @api private
  class ModelNotFound < StandardError

  end # ModeSwitch

  # Raised when Vedeu attempts to parse a {Vedeu.view} or {Vedeu.interface} and
  # encounters a problem.
  #
  # @api private
  class InvalidSyntax < StandardError

  end # InvalidSyntax

  # Raised when a name is not provided for a model when attempting to store it
  # in a repository.
  #
  # @api private
  class MissingRequired < StandardError

  end # MissingRequired

  # Raised intentionally when the client application wishes to switch between
  # cooked and raw (or vice versa) terminal modes.
  #
  # @see Vedeu::Application
  #
  # @api private
  class ModeSwitch < StandardError

  end # ModeSwitch

  # Raised to remind me (or client application developers) that the subclass
  # implements the functionality sought.
  #
  # @see Vedeu::Translator
  #
  # @api private
  class NotImplemented < StandardError

  end # NotImplemented

  # Raised when trying to access an interface column less than 1 or greater
  # than 12. Vedeu is hard-wired to a 12-column layout for the time being.
  #
  # @see Vedeu::Grid
  #
  # @api private
  class OutOfRange < StandardError

  end # OutOfRange

  # Raised when Vedeu wishes to exit.
  #
  # @see Vedeu::MainLoop
  #
  # @api private
  class VedeuInterrupt < StandardError

  end # VedeuInterrupt

end # Vedeu
