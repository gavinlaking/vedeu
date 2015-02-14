require 'vedeu/repositories/repository'

module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Repository

    # @return [Vedeu::Borders]
    def self.borders
      @_borders ||= Vedeu::Borders.new(Vedeu::Border)
    end

  end # Borders

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    # @return [Vedeu::Geometries]
    def self.geometries
      @_geometries ||= Vedeu::Geometries.new(Vedeu::Geometry)
    end

  end # Geometries

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @_menus ||= Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
