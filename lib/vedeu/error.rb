# frozen_string_literal: true

module Vedeu

  # Custom exceptions/errors which Vedeu will raise in certain
  # circumstances.
  #
  # @api private
  #
  module Error

    # Raised with Vedeu attempts to access a client application
    # controller's action that does not exist.
    #
    class ActionNotFound < StandardError

    end # ActionNotFound

    # Raised with Vedeu attempts to access a client application
    # controller that does not exist.
    #
    class ControllerNotFound < StandardError

    end # ControllerNotFound

    # Raised when Vedeu encounters an error it cannot recover from.
    # Generally, all Vedeu exceptions are fatal- however, fatal here
    # means that it is not known how to recover from an error.
    #
    # If you encounter a `Vedeu::Error::Fatal` error and the error
    # message is insufficient to help you, please raise an issue so
    # that we can attempt to accommodate your intentions.
    #
    # An example of this would happen if there was no interfaces, or
    # specifically if there were no entries in {Vedeu::Models::Focus},
    # since the fallback for most of the system when a name is not
    # given or cannot be found is to use the name of the currently
    # focussed interface.
    #
    # @!macro [new] raise_fatal
    #   @raise [Vedeu::Error::Fatal] When Vedeu does not understand
    #     that which the client application is attempting to achieve.
    #
    class Fatal < StandardError

    end # Fatal

    # Raised when Vedeu wishes to exit.
    #
    # @see Vedeu::Runtime::MainLoop
    #
    class Interrupt < StandardError

    end # Interrupt

    # Raised when Vedeu attempts to parse a view or interface and
    # encounters a problem.
    #
    # @!macro [new] raise_invalid_syntax
    #   @raise [Vedeu::Error::InvalidSyntax] When the value given for
    #     an argument or parameter cannot be used because it is not
    #     valid for the use case, unsupported or the method expects a
    #     different type.
    #
    class InvalidSyntax < StandardError

    end # InvalidSyntax

    # Raised when value required by Vedeu to proceed is not given.
    # For example, when a name is not provided for a model when
    # attempting to store it in a repository.
    #
    # @!macro [new] raise_missing_required
    #    @raise [Vedeu::Error::MissingRequired] When the required
    #      argument or parameter was given but without a meaningful or
    #      usable value (e.g. nil).
    #
    class MissingRequired < StandardError

    end # MissingRequired

    # Raised with Vedeu attempts to access a named model that does not
    # exist.
    #
    class ModelNotFound < StandardError

    end # ModelNotFound

    # Raised intentionally when the client application wishes to
    # switch between cooked, fake and raw terminal modes.
    #
    # @see Vedeu::Runtime::Application
    #
    class ModeSwitch < StandardError

    end # ModeSwitch

    # Raised to remind me (or client application developers) that the
    # subclass implements the functionality sought.
    #
    # @!macro [new] raise_not_implemented
    #    @raise [Vedeu::Error::NotImplemented] When the method called
    #      should be handled by a subclass of the current class, or
    #      by the class including or extending the current module.
    #
    class NotImplemented < StandardError

      # Returns an error message.
      #
      # @return [String]
      def message
        'Subclasses of this class or classes including/extending ' \
        'this module should implement this method.'
      end

    end # NotImplemented

    # Raised when trying to access an interface column less than 1 or
    # greater than 12. Vedeu is hard-wired to a 12-column layout for
    # the time being.
    #
    # @see Vedeu::Geometries::Grid
    #
    # @!macro [new] raise_out_of_range
    #   @raise [Vedeu::Error::OutOfRange] When the value given for
    #     an argument or parameter cannot be used because it is
    #     outside the allowed range.
    #
    class OutOfRange < StandardError

      # Returns an error message.
      #
      # @return [String]
      def message
        'Valid value is between 1 and 12 inclusive.'
      end

    end # OutOfRange

    # Raised when a method requiring a block was not given the block.
    #
    # @!macro [new] raise_requires_block
    #    @raise [Vedeu::Error::RequiresBlock] When the required block
    #      was not given.
    #
    class RequiresBlock < StandardError

      # Returns an error message.
      #
      # @return [String]
      def message
        'The required block was not given.'
      end

    end

  end # Error

end # Vedeu
