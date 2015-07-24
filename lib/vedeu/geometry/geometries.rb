require 'vedeu/null/geometry'
require 'vedeu/geometry/geometry'

module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Vedeu::Repository

    class << self

      alias_method :geometries, :repository

    end # Eigenclass

    null Vedeu::Null::Geometry
    real Vedeu::Geometry

  end # Geometries

end # Vedeu
