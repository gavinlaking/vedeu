# frozen_string_literal: true

module Vedeu

  # Provide delegation methods for Vedeu::Geometries::Geometry.
  #
  # @api private
  #
  class XCoordinate

    # @param geometry [Vedeu::Geometries::Geometry]
    # @return [Vedeu::XCoordinate]
    def initialize(geometry)
      @geometry = geometry
    end

    # Return the :x value from the geometry.
    #
    # @return [Integer]
    def d
      geometry.x
    end
    alias x d

    # Return the :bx value from the geometry.
    #
    # @return [Integer]
    def bd
      geometry.bx
    end
    alias bx bd

    # Return the :bxn value from the geometry.
    #
    # @return [Integer]
    def bdn
      geometry.bxn
    end
    alias bxn bdn

    # Return the :bordered_width value from the geometry.
    #
    # @return [Integer]
    def d_dn
      geometry.bordered_width
    end
    alias bordered_width d_dn

    protected

    # @!attribute [r] geometry
    # @return [Vedeu::Geometries::Geometry]
    attr_reader :geometry

  end # XCoordinate

end # Vedeu
