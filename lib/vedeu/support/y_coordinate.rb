# frozen_string_literal: true

module Vedeu

  # Provide delegation methods for Vedeu::Geometries::Geometry.
  #
  # @api private
  #
  class YCoordinate

    # @param geometry [Vedeu::Geometries::Geometry]
    # @return [Vedeu::YCoordinate]
    def initialize(geometry)
      @geometry = geometry
    end

    # Return the :y value from the geometry.
    #
    # @return [Integer]
    def d
      geometry.y
    end
    alias y d

    # Return the :by value from the geometry.
    #
    # @return [Integer]
    def bd
      geometry.by
    end
    alias by bd

    # Return the :byn value from the geometry.
    #
    # @return [Integer]
    def bdn
      geometry.byn
    end
    alias byn bdn

    # Return the :bordered_height value from the geometry.
    #
    # @return [Integer]
    def d_dn
      geometry.bordered_height
    end
    alias bordered_height d_dn

    protected

    # @!attribute [r] geometry
    # @return [Vedeu::Geometries::Geometry]
    attr_reader :geometry

  end # YCoordinate

end # Vedeu
