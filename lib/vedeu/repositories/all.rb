require 'vedeu/repositories/collection'
require 'vedeu/repositories/collections'
require 'vedeu/repositories/model'
require 'vedeu/repositories/repository'

module Vedeu

  module Repositories

    extend self

    def register(klass)
      storage.add(klass)
    end

    def reset!
      storage.map(&:repository).map { |repository| repository.send(:reset) }

      true
    end

    private

    # Access to the storage for this repository.
    #
    # @return [Array]
    def storage
      @storage ||= Set.new
    end

  end

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Repository

    # @return [Vedeu::Borders]
    def self.borders
      @borders ||= reset! # Vedeu::Borders.new(Vedeu::Border)
    end

    def self.repository
      Vedeu.borders
    end

    def self.reset!
      @borders = Vedeu::Borders.register_repository(Vedeu::Border)
    end

  end # Borders

  # Allows the storing of view buffers.
  #
  class Buffers < Repository

    # @return [Vedeu::Buffers]
    def self.buffers
      @buffers ||= reset!
    end

    def self.repository
      Vedeu.buffers
    end

    def self.reset!
      @buffers = Vedeu::Buffers.register_repository(Vedeu::Buffer)
    end

  end # Buffers

  # Allows the storing of HTML/CSS colours and their respective escape
  # sequences.
  #
  class Colours

    # @!attribute [r] storage
    # @return [Hash<String => String>]
    attr_reader :storage

    # Returns a new instance of Vedeu::Colours.
    #
    # @return [Vedeu::Colours]
    def initialize
      @storage = {}
    end

    # Registers a colour with respective escape sequence.
    #
    # @return [String]
    def register(colour, escape_sequence)
      storage.store(colour, escape_sequence)
    end

    # Returns a boolean indicating whether the colour has been registered.
    #
    # @return [Boolean]
    def registered?(colour)
      storage.key?(colour)
    end

    # Removes all stored colours.
    #
    # @return [Hash]
    def reset!
      storage.clear
    end

    # Retrieves a registered colour.
    #
    # @return [String]
    def retrieve(colour)
      storage.fetch(colour, '')
    end

    # Retrieves a registered colour, or registers the colour with its respective
    # escape sequence.
    #
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
      @cursors ||= reset!
    end

    # @return [Vedeu::Cursor]
    def self.cursor
      cursors.current
    end

    def self.repository
      Vedeu.cursors
    end

    def self.reset!
      @cursors = Vedeu::Cursors.register_repository(Vedeu::Cursor)
    end

  end # Cursors

  # Allows the storing of events.
  #
  class EventsRepository < Repository

    # @return [Vedeu::EventsRepository]
    def self.events
      @events ||= reset!
    end

    def self.repository
      Vedeu.events
    end

    def self.reset!
      @events = Vedeu::EventsRepository.new(Vedeu::Events)
    end

  end # EventsRepository

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    # @return [Vedeu::Geometries]
    def self.geometries
      @geometries ||= reset!
    end

    def self.repository
      Vedeu.geometries
    end

    def self.reset!
      @geometries = Vedeu::Geometries.new(Vedeu::Geometry)
    end

  end # Geometries

  # Allows the storing of view groups.
  #
  class Groups < Repository

    # @return [Vedeu::Groups]
    def self.groups
      @groups ||= reset!
    end

    def self.repository
      Vedeu.groups
    end

    def self.reset!
      @groups = Vedeu::Groups.new(Vedeu::Group)
    end

  end # Groups

  # Allows the storing of interfaces and views.
  #
  class InterfacesRepository < Repository

    # @return [Vedeu::InterfacesRepository]
    def self.interfaces
      @interfaces ||= reset!
    end

    def self.repository
      Vedeu.interfaces
    end

    def self.reset!
      @interfaces = Vedeu::InterfacesRepository.new(Vedeu::Interface)
    end

  end # InterfacesRepository

  # Allows the storing of keymaps.
  #
  class Keymaps < Repository

    # @return [Vedeu::Keymaps]
    def self.keymaps
      @keymaps ||= reset!
    end

    def self.repository
      Vedeu.keymaps
    end

    def self.reset!
      @keymaps = Vedeu::Keymaps.new(Vedeu::Keymap)
    end

  end # Keymaps

  # Allows the storing of menus by name.
  #
  class Menus < Repository

    # @return [Vedeu::Menus]
    def self.menus
      @menus ||= reset!
    end

    def self.repository
      Vedeu.menus
    end

    def self.reset!
      @menus = Vedeu::Menus.new(Vedeu::Menu)
    end

  end # Menus

end # Vedeu
