module Vedeu

  # Custom exceptions/errors which Vedeu will raise in certain circumstances.
  #
  module Error

    # Raised with Vedeu attempts to access a client application controller's
    # action that does not exist.
    #
    class ActionNotFound < StandardError

    end # ActionNotFound

    # Raised with Vedeu attempts to access a client application controller that
    # does not exist.
    #
    class ControllerNotFound < StandardError

    end # ControllerNotFound

    # Raised when Vedeu encounters an error.
    #
    class Fatal < StandardError

    end # Fatal

    # Raised when Vedeu wishes to exit.
    #
    # @see Vedeu::MainLoop
    #
    class Interrupt < StandardError

    end # Interrupt

    # Raised when Vedeu attempts to parse a view or interface and encounters a
    # problem.
    #
    class InvalidSyntax < StandardError

    end # InvalidSyntax

    # Raised when a name is not provided for a model when attempting to store it
    # in a repository.
    #
    class MissingRequired < StandardError

    end # MissingRequired

    # Raised with Vedeu attempts to access a named model that does not exist.
    #
    class ModelNotFound < StandardError

    end # ModelNotFound

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
    # @see Vedeu::Colours::Translator
    #
    class NotImplemented < StandardError

    end # NotImplemented

    # Raised when trying to access an interface column less than 1 or greater
    # than 12. Vedeu is hard-wired to a 12-column layout for the time being.
    #
    # @see Vedeu::Geometry::Grid
    #
    class OutOfRange < StandardError

      # @return [String]
      def message
        'Valid value is between 1 and 12 inclusive.'
      end

    end # OutOfRange

  end # Error

end # Vedeu
