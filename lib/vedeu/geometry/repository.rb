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

  # Manipulate the repository of geometries.
  #
  # @example
  #   Vedeu.geometries
  #
  # @!method geometries
  # @return [Vedeu::Geometry::Repository]
  def_delegators Vedeu::Geometry::Repository, :geometries

end # Vedeu
