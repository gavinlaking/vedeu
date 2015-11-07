module Vedeu

  module Geometry

    # The X Dimension provides the width of an entity.
    #
    class XDimension < Vedeu::Geometry::Dimension

      private

      # @see Vedeu::Geometry::Dimension#defaults
      def defaults
        super.merge!(default: Vedeu.width)
      end

    end # XDimension

  end # Geometry

end # Vedeu
