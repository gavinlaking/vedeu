require 'vedeu/repositories/collection'
require 'vedeu/repositories/collections'
require 'vedeu/repositories/model'
require 'vedeu/repositories/repository'

module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Repository

    # @return [Vedeu::Borders]
    def self.borders
      @borders ||= Vedeu::Borders.new(Vedeu::Border)
    end

  end # Borders

  # Allows the storing of view buffers.
  #
  class Buffers < Repository

    # @return [Vedeu::Buffers]
    def self.buffers
      @buffers ||= Vedeu::Buffers.new(Vedeu::Buffer)
    end

  end # Buffers


  # Allows the storing of HTML/CSS colours and their respective escape
  # sequences.
  #
  class Colours

    # @!attribute [r] storage
    # @return [Hash<String => String>]
    attr_reader :storage

    # @return [Vedeu::Colours]
    def initialize
      @storage = {}
    end

    # @return [String]
    def register(colour, escape_sequence)
      storage.store(colour, escape_sequence)
    end

    # @return [Boolean]
    def registered?(colour)
      storage.key?(colour)
    end

    # @return [String]
    def retrieve(colour)
      storage.fetch(colour, '')
    end

    # @return [String]
    def retrieve_or_register(colour, escape_sequence)
      if registered?(colour)
        retrieve(colour)

      else
        register(colour, escape_sequence)

      end
    end

  end # Colours

  # Store background colour escape sequences by HTML/CSS code.
  #
  class BackgroundColours < Colours

    # @return [Vedeu::BackgroundColours]
    def self.background_colours
      @background_colours ||= new
    end

  end # BackgroundColours

  # Store foreground colour escape sequences by HTML/CSS code.
  #
  class ForegroundColours < Colours

    # @return [Vedeu::ForegroundColours]
    def self.foreground_colours
      @foreground_colours ||= new
    end

  end # ForegroundColours

  # Allows the storing of each interface's cursor.
  #
  class Cursors < Repository

    # @return [Vedeu::Cursors]
    def self.cursors
      @cursors ||= Vedeu::Cursors.new(Vedeu::Cursor)
    end

    # @return [Vedeu::Cursor]
    def self.cursor
      cursors.current
    end

  end # Cursors

  # Allows the storing of events.
  #
  class EventsRepository < Repository

    # @return [Vedeu::EventsRepository]
    def self.events
      @events ||= Vedeu::EventsRepository.new(Vedeu::Events)
    end

  end # EventsRepository

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    # @return [Vedeu::Geometries]
    def self.geometries
      @geometries ||= Vedeu::Geometries.new(Vedeu::Geometry)
    end

  end # Geometries

  # Allows the storing of view groups.
  #
  class Groups < Repository

    # @return [Vedeu::Groups]
    def self.groups
      @groups ||= Vedeu::Groups.new(Vedeu::Group)
    end

  end # Groups

  # Allows the storing of interfaces and views.
  #
  class InterfacesRepository < Repository

    # @return [Vedeu::InterfacesRepository]
    def self.interfaces
      @interfaces ||= Vedeu::InterfacesRepository.new(Vedeu::Interface)
    end

  end # InterfacesRepository

  # Allows the storing of keymaps.
  #
  class Keymaps < Repository

    # @return [Vedeu::Keymaps]
    def self.keymaps
      @keymaps ||= Vedeu::Keymaps.new(Vedeu::Keymap)
    end

  end # Keymaps

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @menus ||= Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
