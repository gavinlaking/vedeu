module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    # @return [Vedeu::Geometries]
    def self.geometries
      @geometries ||= reset!
    end

    # @return [Vedeu::Geometries]
    def self.repository
      Vedeu.geometries
    end

    # @return [Vedeu::Geometries]
    def self.reset!
      @geometries = Vedeu::Geometries.new(Vedeu::Geometry)
    end

    # @param name [String] The name of the stored geometry.
    # @return [Vedeu::Geometry|Vedeu::NullGeometry]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::NullGeometry.new

      end
    end

  end # Geometries

end # Vedeu
