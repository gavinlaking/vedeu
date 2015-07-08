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

    # Manipulate the repository of background colours.
    #
    # @example
    #   Vedeu.background_colours
    #
    # @!method background_colours
    # @return [Vedeu::Backgrounds]
    def_delegators Vedeu::Backgrounds, :background_colours

    # Manipulate the repository of borders.
    #
    # @example
    #   Vedeu.borders
    #
    # @!method borders
    # @return [Vedeu::Borders]
    def_delegators Vedeu::Borders, :borders

    # Manipulate the repository of buffers.
    #
    # @example
    #   Vedeu.buffers
    #
    # @!method buffers
    # @return [Vedeu::Buffers]
    def_delegators Vedeu::Buffers, :buffers

    # @!method configure
    #   @see Vedeu::Configuration.configure
    # @!method configuration
    #   @see Vedeu::Configuration.configuration
    def_delegators Vedeu::Configuration, :configure, :configuration

    # Manipulate the currently focussed cursor.
    #
    # @example
    #   Vedeu.cursor
    #
    # @!method cursor
    # @return [Vedeu::Cursor]
    def_delegators Vedeu::Cursors, :cursor

    # Manipulate the repository of cursors.
    #
    # @example
    #   Vedeu.cursors
    #
    # @!method cursors
    # @return [Vedeu::Cursors]
    def_delegators Vedeu::Cursors, :cursors

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

    # @!method interface
    #   @see Vedeu::DSL::View.interface
    # @!method render
    #   @see Vedeu::DSL::View.render
    # @!method renders
    #   @see Vedeu::DSL::View.renders
    # @!method views
    #   @see Vedeu::DSL::View.views
    def_delegators Vedeu::DSL::View, :interface, :renders, :render, :views

    # @!method bind
    #   @see Vedeu::Event.bind
    # @!method unbind
    #   @see Vedeu::Event.unbind
    def_delegators Vedeu::Event, :bind, :unbind

    # Manipulate the repository of events.
    #
    # @example
    #   Vedeu.events
    #
    # @!method events
    # @return [Vedeu::Events]
    def_delegators Vedeu::Events, :events

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

    # Manipulate the repository of foreground colours.
    #
    # @example
    #   Vedeu.foreground_colours
    #
    # @!method foreground_colours
    # @return [Vedeu::Foregrounds]
    def_delegators Vedeu::Foregrounds, :foreground_colours

    # Manipulate the repository of geometries.
    #
    # @example
    #   Vedeu.geometries
    #
    # @!method geometries
    # @return [Vedeu::Geometries]
    def_delegators Vedeu::Geometries, :geometries

    # Manipulate the repository of groups.
    #
    # @example
    #   Vedeu.groups
    #
    # @!method groups
    # @return [Vedeu::Groups]
    def_delegators Vedeu::Groups, :groups

    # Manipulate the repository of interfaces.
    #
    # @example
    #   Vedeu.interfaces
    #
    # @!method interfaces
    # @return [Vedeu::Interfaces]
    def_delegators Vedeu::Interfaces, :interfaces

    # Manipulate the repository of keymaps.
    #
    # @example
    #   Vedeu.keymaps
    #
    # @!method keymaps
    # @return [Vedeu::Keymaps]
    def_delegators Vedeu::Keymaps, :keymaps

    # @!method log
    #   @see Vedeu::Log.log
    # @!method log_stdout
    #   @see Vedeu::Log.log_stdout
    # @!method log_stderr
    #   @see Vedeu::Log.log_stderr
    def_delegators Vedeu::Log, :log, :log_stdout, :log_stderr

    # @!method keypress
    #   @see Vedeu::Mapper.keypress
    def_delegators Vedeu::Mapper, :keypress

    # @!method menu
    #   @see Vedeu::Menu.menu
    def_delegators Vedeu::Menu, :menu

    # Manipulate the repository of menus.
    #
    # @example
    #   Vedeu.menus
    #
    # @!method menus
    # @return [Vedeu::Menus]
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
