module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  # @api public
  class Geometries < Repository

    class << self

      # @return [Vedeu::Geometries]
      alias_method :geometries, :repository

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Geometries]
      def reset!
        @geometries = register(Vedeu::Geometry)
      end

    end

    null Vedeu::Null::Geometry
    # real Vedeu::Geometry

  end # Geometries

end # Vedeu
