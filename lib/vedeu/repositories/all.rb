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

  # Allows the storing of view buffers.
  #
  class Buffers < Repository

    # @return [Vedeu::Buffers]
    def self.buffers
      @_buffers ||= Vedeu::Buffers.new(Vedeu::Buffer)
    end

  end # Buffers

  # Allows the storing of each interface's cursor.
  #
  class Cursors < Repository

    # @return [Vedeu::Cursors]
    def self.cursors
      @_cursors ||= Vedeu::Cursors.new(Vedeu::Cursor)
    end

    # @return [Vedeu::Cursor]
    def self.cursor
      cursors.current
    end

  end # Cursors

  # Allows the storing of events.
  #
  class Events < Repository

    # @return [Vedeu::Events]
    def self.events
      @_events ||= Vedeu::Events.new(Vedeu::Model::Collection)
    end

  end # Events

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    # @return [Vedeu::Geometries]
    def self.geometries
      @_geometries ||= Vedeu::Geometries.new(Vedeu::Geometry)
    end

  end # Geometries

  # Allows the storing of view groups.
  #
  class Groups < Repository

    # @return [Vedeu::Groups]
    def self.groups
      @_groups ||= Vedeu::Groups.new(Vedeu::Group)
    end

  end # Groups

  # Allows the storing of interfaces and views.
  #
  class InterfacesRepository < Repository

    # @return [Vedeu::InterfacesRepository]
    def self.interfaces
      @_interfaces ||= Vedeu::InterfacesRepository.new(Vedeu::Interface)
    end

  end # InterfacesRepository

  # Allows the storing of keymaps.
  #
  class Keymaps < Repository

    # @return [Vedeu::Keymaps]
    def self.keymaps
      @_keymaps ||= Vedeu::Keymaps.new(Vedeu::Keymap)
    end

  end # Keymaps

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @_menus ||= Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
