module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Vedeu::Repository

    singleton_class.send(:alias_method, :geometries, :repository)

    null Vedeu::Null::Geometry
    real Vedeu::Geometry

  end # Geometries

end # Vedeu
