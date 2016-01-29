# frozen_string_literal: true

module Vedeu

  module Geometries

    # The Y Dimension provides the height of an entity.
    #
    # @api private
    #
    class YDimension < Vedeu::Geometries::Dimension

      private

      # @macro defaults_method
      def defaults
        super.merge!(default: Vedeu.height)
      end

    end # YDimension

  end # Geometries

end # Vedeu
