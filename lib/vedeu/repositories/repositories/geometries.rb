module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  # @api public
  class Geometries < Repository

    class << self

      alias_method :geometries, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.geometries.reset!
      #
      # @return [Vedeu::Geometries]
      def reset!
        @geometries = register(Vedeu::Geometry)
      end
      alias_method :reset, :reset!

    end # Eigenclass

    null Vedeu::Null::Geometry
    # real Vedeu::Geometry

  end # Geometries

end # Vedeu
