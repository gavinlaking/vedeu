module Vedeu

  module Geometry

    # The Y Dimension provides the height of an entity.
    #
    class YDimension < Vedeu::Geometry::Dimension

      private

      # @return [Vedeu::Geometry::VerticalAlignment]
      def alignment
        Vedeu::Geometry::Alignment.coerce(@alignment)
      end

      # @return [Hash<Symbol => NilClass,Boolean,Symbol>]
      def defaults
        super.merge!(
          default:   Vedeu.height,
          alignment: :none,
        )
      end

    end # YDimension

  end # Geometry

end # Vedeu
