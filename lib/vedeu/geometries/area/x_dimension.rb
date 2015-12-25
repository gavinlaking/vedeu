# frozen_string_literal: true

module Vedeu

  module Geometries

    # The X Dimension provides the width of an entity.
    #
    # @api private
    #
    class XDimension < Vedeu::Geometries::Dimension

      private

      # @see Vedeu::Geometries::Dimension#defaults
      def defaults
        super.merge!(default: Vedeu.width)
      end

    end # XDimension

  end # Geometries

end # Vedeu
