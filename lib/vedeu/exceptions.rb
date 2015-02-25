module Vedeu

  # ModelNotFound: Raised with Vedeu attempts to access a named model that does
  #   not exist.
  #
  # InvalidSyntax: Raised when Vedeu attempts to parse a {Vedeu.view} or
  #   {Vedeu.interface} and encounters a problem.
  #
  # MissingRequired: Raised when a name is not provided for a model when
  #   attempting to store it in a repository.
  #
  # ModeSwitch: Raised intentionally when the client application wishes to
  #   switch between cooked and raw (or vice versa) terminal modes. Vedeu is
  #   hard-wired to use the `Escape` key to trigger this change for the time
  #   being.
  #
  # NotImplemented: Raised to remind me (or client application developers) that
  #   the subclass implements the functionality sought.
  #
  # OutOfRange: Raised when trying to access an interface column less than 1 or
  #   greater than 12. Vedeu is hard-wired to a 12-column layout for the time
  #   being.
  #
  # VedeuInterrupt: Raised when Vedeu wishes to exit.
  #
  Exceptions = %w[
    ModelNotFound
    InvalidSyntax
    MissingRequired
    ModeSwitch
    NotImplemented
    OutOfRange
    VedeuInterrupt
  ]
  Exceptions.each { |e| const_set(e, Class.new(StandardError)) }

end # Vedeu
