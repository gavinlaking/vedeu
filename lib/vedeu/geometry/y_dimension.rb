module Vedeu

  module Geometry

    # The Y Dimension provides the height of an entity.
    #
    class YDimension < Vedeu::Geometry::Dimension

      private

      # @return [Symbol]
      def alignment
        vertical_alignment
      end

      # @return [Hash<Symbol => NilClass,Boolean,Symbol>]
      def defaults
        super.merge!(
          default:            Vedeu.height,
          vertical_alignment: default_alignment,
        )
      end

      # @return [Symbol]
      def default_alignment
        Vedeu::Geometry::VerticalAlignment.align(:none)
      end

    end # YDimension

  end # Geometry

end # Vedeu
