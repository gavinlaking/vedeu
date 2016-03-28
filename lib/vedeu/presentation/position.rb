# frozen_string_literal: true

module Vedeu

  module Presentation

    # Provide position functionality to the including model.
    #
    # @api private
    #
    module Position

      # Gets the position.
      #
      # @return [NilClass|Vedeu::Geometries::Position]
      def position
        Vedeu::Geometries::Position.coerce(@position)
      end

      # Sets the position.
      #
      # @param value [Array<void>|Hash<void>|
      #   Vedeu::Geometries::Position]
      # @return [NilClass|Vedeu::Geometries::Position]
      def position=(value)
        @position = Vedeu::Geometries::Position.coerce(value)
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

      private

      # @macro param_block
      # @return [String]
      def render_position(&block)
        return position.to_s { yield } if position?

        yield
      end

    end # Position

  end # Presentation

end # Vedeu
