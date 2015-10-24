module Vedeu

  module Geometry

    # The X Dimension provides the width of an entity.
    #
    class XDimension < Vedeu::Geometry::Dimension

      private

      # @return [Vedeu::Geometry::HorizontalAlignment]
      def alignment
        Vedeu::Geometry::Alignment.coerce(@alignment)
      end

      # @return [Hash<Symbol => NilClass,Boolean,Symbol>]
      def defaults
        super.merge!(
          default:   Vedeu.width,
          alignment: :none,
        )
      end

    end # XDimension

  end # Geometry

end # Vedeu
