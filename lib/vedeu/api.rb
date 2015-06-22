require 'vedeu/support/common'
require 'vedeu/support/terminal'
require 'vedeu/support/timer'
require 'vedeu/output/renderers/all'
require 'vedeu/events/all'
require 'vedeu/models/all'
require 'vedeu/input/all'
require 'vedeu/dsl/all'

module Vedeu

  # Provides the API to Vedeu. Methods therein, and classes belonging to this
  # module expose Vedeu's core functionality.
  #
  # These methods are used in a variety of ways, sometimes in combination:
  #
  #   # with parameters
  #   Vedeu.method_name(*params)
  #
  #   # with a block
  #   Vedeu.method_name(*params) do
  #     # ...
  #   end
  #
  #   # with other methods
  #   Vedeu.method_name.other_method
  #
  # @api public
  #
  module API

    extend Forwardable

    module_function

    # @!method background_colours
    #   @see Vedeu::BackgroundColours.background_colours
    def_delegators Vedeu::BackgroundColours, :background_colours

    # @!method borders
    #   @see Vedeu::Borders.borders
    def_delegators Vedeu::Borders, :borders

    # @!method buffers
    #   @see Vedeu::Buffers.buffers
    def_delegators Vedeu::Buffers, :buffers

    # @!method configure
    #   @see Vedeu::Configuration.configure
    # @!method configuration
    #   @see Vedeu::Configuration.configuration
    def_delegators Vedeu::Configuration, :configure, :configuration

    # @!method cursor
    #   @see Vedeu::Cursors.cursor
    # @!method cursors
    #   @see Vedeu::Cursors.cursors
    def_delegators Vedeu::Cursors, :cursor, :cursors

    # @!method border
    #   @see Vedeu::DSL::Border.border
    def_delegators Vedeu::DSL::Border, :border

    # @!method geometry
    #   @see Vedeu::DSL::Geometry.geometry
    def_delegators Vedeu::DSL::Geometry, :geometry

    # @!method group
    #   @see Vedeu::DSL::Group.group
    def_delegators Vedeu::DSL::Group, :group

    # @!method keymap
    #   @see Vedeu::DSL::Keymap.keymap
    def_delegators Vedeu::DSL::Keymap, :keymap

    # @!method use
    #   @see Vedeu::DSL::Use.use
    def_delegators Vedeu::DSL::Use, :use

    # @!method interface
    #   @see Vedeu::DSL::View.interface
    # @!method renders
    #   @see Vedeu::DSL::View.renders
    # @!method views
    #   @see Vedeu::DSL::View.views
    def_delegators Vedeu::DSL::View, :interface, :renders, :views

    # @!method bind
    #   @see Vedeu::Event.bind
    # @!method unbind
    #   @see Vedeu::Event.unbind
    def_delegators Vedeu::Event, :bind, :unbind

    # @!method events
    #   @see Vedeu::EventsRepository.events
    def_delegators Vedeu::EventsRepository, :events

    # @!method focus
    #   @see Vedeu::Focus#focus
    # @!method focus_by_name
    #   @see Vedeu::Focus#focus_by_name
    # @!method focussed?
    #   @see Vedeu::Focus#focussed?
    # @!method focus_next
    #   @see Vedeu::Focus#focus_next
    # @!method focus_previous
    #   @see Vedeu::Focus#focus_previous
    def_delegators Vedeu::Focus, :focus, :focus_by_name, :focussed?,
                   :focus_next, :focus_previous

    # @!method foreground_colours
    #   @see Vedeu::ForegroundColours.foreground_colours
    def_delegators Vedeu::ForegroundColours, :foreground_colours

    # @!method geometries
    #   @see Vedeu::Geometries.geometries
    def_delegators Vedeu::Geometries, :geometries

    # @!method groups
    #   @see Vedeu::Groups.groups
    def_delegators Vedeu::Groups, :groups

    # @!method interfaces
    #   @see Vedeu::InterfacesRepository.interfaces
    def_delegators Vedeu::InterfacesRepository, :interfaces

    # @!method keymaps
    #   @see Vedeu::Keymaps.keymaps
    def_delegators Vedeu::Keymaps, :keymaps

    # @!method log
    #   @see Vedeu::Log.log
    def_delegators Vedeu::Log, :log

    # @!method keypress
    #   @see Vedeu::Mapper.keypress
    def_delegators Vedeu::Mapper, :keypress

    # @!method menu
    #   @see Vedeu::Menu.menu
    def_delegators Vedeu::Menu, :menu

    # @!method menus
    #   @see Vedeu::Menus.menus
    def_delegators Vedeu::Menus, :menus

    # @!method renderer
    #   @see Vedeu::Renderers#renderer
    # @!method renderers
    #   @see Vedeu::Renderers#renderers
    def_delegators Vedeu::Renderers, :renderer, :renderers

    # @!method height
    #   @see Vedeu::Terminal#height
    # @!method width
    #   @see Vedeu::Terminal#width
    # @!method resize
    #   @see Vedeu::Terminal#resize
    def_delegators Vedeu::Terminal, :height, :width, :resize

    # @!method timer
    #   @see Vedeu::Timer.timer
    def_delegators Vedeu::Timer, :timer

    # @!method trigger
    #   @see Vedeu::Trigger.trigger
    def_delegators Vedeu::Trigger, :trigger

  end # API

  extend API

end # Vedeu
