# frozen_string_literal: true

module Vedeu

  module Geometries

    # Allows the storing of interface/view geometry independent of the
    # interface instance.
    #
    class Repository < Vedeu::Repositories::Repository

      null Vedeu::Geometries::Geometry
      real Vedeu::Geometries::Geometry

    end # Repository

  end # Geometries

  # Manipulate the repository of geometries.
  #
  # @example
  #   Vedeu.geometries
  #
  # @api public
  # @!method geometries
  # @return [Vedeu::Geometries::Repository]
  def_delegators Vedeu::Geometries::Repository,
                 :geometries

end # Vedeu
