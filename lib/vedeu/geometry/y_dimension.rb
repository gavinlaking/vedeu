module Vedeu

  module Geometry

    # The Y Dimension provides the height of an entity.
    #
    class YDimension < Vedeu::Geometry::Dimension

      private

      # @see Vedeu::Geometry::Dimension#defaults
      def defaults
        super.merge!(default: Vedeu.height)
      end

    end # YDimension

  end # Geometry

end # Vedeu
