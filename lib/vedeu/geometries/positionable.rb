module Vedeu

  module Geometries

    # Provide position functionality to the including model.
    #
    # @api private
    #
    module Positionable

      # Gets the position.
      #
      # @return [Vedeu::Geometries::Position]
      def position
        @_position ||= Vedeu::Geometries::Position.coerce(@position)
      end

      # Sets the position.
      #
      # @param value [Array<void>|Hash<void>|
      #   Vedeu::Geometries::Position]
      # @return [Vedeu::Geometries::Position]
      def position=(value)
        @_position = @position = Vedeu::Geometries::Position.coerce(value)
      end

      # Returns a boolean indicating the position attribute of the
      # including model is set.
      #
      # @return [Boolean]
      def position?
        position.is_a?(Vedeu::Geometries::Position)
      end

      # Returns the x coordinate for the model when the position
      # attribute of the including model is set.
      #
      # @return [Fixnum|NilClass]
      def x
        position.x if position?
      end

      # Returns the y coordinate for the model when the position
      # attribute of the including model is set.
      #
      # @return [Fixnum|NilClass]
      def y
        position.y if position?
      end

    end # Positionable

  end # Geometries

end # Vedeu
