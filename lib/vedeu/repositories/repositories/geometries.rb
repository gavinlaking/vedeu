module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    class << self

      # @return [Vedeu::Geometries]
      def geometries
        @geometries ||= reset!
      end
      alias_method :repository, :geometries

      # @return [Vedeu::Geometries]
      def reset!
        @geometries = Vedeu::Geometries.register_repository(Vedeu::Geometry)
      end

    end

    # @param name [String] The name of the stored geometry.
    # @return [Vedeu::Geometry|Vedeu::NullGeometry]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::NullGeometry.new(name)

      end
    end

  end # Geometries

end # Vedeu
