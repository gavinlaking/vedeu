require 'vedeu/repositories/repository'

module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    # @return [Vedeu::Geometries]
    def self.geometries
      @_geometries ||= Vedeu::Geometries.new(Vedeu::Geometry)
    end

  end # Geometries

end # Vedeu
