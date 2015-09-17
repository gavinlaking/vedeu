module Vedeu

  module Geometry

    # Allows the storing of interface/view geometry independent of the
    # interface instance.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :geometries, :repository)

      null Vedeu::Geometry::Null
      real Vedeu::Geometry::Geometry

    end # Repository

  end # Geometry

end # Vedeu
