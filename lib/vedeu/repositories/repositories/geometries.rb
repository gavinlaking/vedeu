module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    # @return [Vedeu::Geometries]
    def self.geometries
      @geometries ||= reset!
    end

    def self.repository
      Vedeu.geometries
    end

    def self.reset!
      @geometries = Vedeu::Geometries.new(Vedeu::Geometry)
    end

  end # Geometries

end # Vedeu
