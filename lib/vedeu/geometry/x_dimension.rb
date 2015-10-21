module Vedeu

  module Geometry

    # The X Dimension provides the width of an entity.
    #
    class XDimension < Vedeu::Geometry::Dimension

      private

      # @return [Symbol]
      def alignment
        horizontal_alignment
      end

      # @return [Hash<Symbol => NilClass,Boolean,Symbol>]
      def defaults
        super.merge!(
          default:              Vedeu.width,
          horizontal_alignment: default_alignment,
        )
      end

      # @return [Symbol]
      def default_alignment
        Vedeu::Geometry::HorizontalAlignment.align(:none)
      end

    end # XDimension

  end # Geometry

end # Vedeu
