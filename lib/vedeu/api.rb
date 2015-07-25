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

    # Manipulate the DRb server implementation.
    #
    # @example
    #   Vedeu.drb_restart
    #   Vedeu.drb_start
    #   Vedeu.drb_status
    #   Vedeu.drb_stop
    #
    # @!method drb_restart
    #   @see Vedeu::Distributed::Server#restart
    # @!method drb_start
    #   @see Vedeu::Distributed::Server#start
    # @!method drb_status
    #   @see Vedeu::Distributed::Server#status
    # @!method drb_stop
    #   @see Vedeu::Distributed::Server#stop
    def_delegators Vedeu::Distributed::Server, :drb_restart, :drb_start,
                   :drb_status, :drb_stop

    # @example
    #   Vedeu.border
    #
    # @!method border
    #   @see Vedeu::DSL::Border.border
    def_delegators Vedeu::DSL::Border, :border

    # @example
    #   Vedeu.geometry
    #
    # @!method geometry
    #   @see Vedeu::DSL::Geometry.geometry
    def_delegators Vedeu::DSL::Geometry, :geometry

    # @example
    #   Vedeu.group
    #
    # @!method group
    #   @see Vedeu::DSL::Group.group
    def_delegators Vedeu::DSL::Group, :group

    # @example
    #   Vedeu.keymap
    #
    # @!method keymap
    #   @see Vedeu::DSL::Keymap.keymap
    def_delegators Vedeu::DSL::Keymap, :keymap

    # @example
    #   Vedeu.interface
    #   Vedeu.renders
    #   Vedeu.render
    #   Vedeu.views
    #
    # @!method interface
    #   @see Vedeu::DSL::View.interface
    # @!method render
    #   @see Vedeu::DSL::View.render
    # @!method renders
    #   @see Vedeu::DSL::View.renders
    # @!method views
    #   @see Vedeu::DSL::View.views
    def_delegators Vedeu::DSL::View, :interface, :renders, :render, :views

    # @example
    #   Vedeu.bind
    #   Vedeu.bound?
    #   Vedeu.unbind
    #
    # @!method bind
    #   @see Vedeu::Event.bind
    # @!method bound?
    #   @see Vedeu::Event.bound?
    # @!method unbind
    #   @see Vedeu::Event.unbind
    def_delegators Vedeu::Event, :bind, :bound?, :unbind

    # Manipulate the repository of events.
    #
    # @example
    #   Vedeu.events
    #
    # @!method events
    # @return [Vedeu::Events]
    def_delegators Vedeu::Events, :events

    # @example
    #   Vedeu.focus
    #   Vedeu.focus_by_name
    #   Vedeu.focussed?
    #   Vedeu.focus_next
    #   Vedeu.focus_previous
    #
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

    # @example
    #   Vedeu.log
    #   Vedeu.log_stdout
    #   Vedeu.log_stderr
    #
    # @!method log
    #   @see Vedeu::Log.log
    # @!method log_stdout
    #   @see Vedeu::Log.log_stdout
    # @!method log_stderr
    #   @see Vedeu::Log.log_stderr
    def_delegators Vedeu::Log, :log, :log_stdout, :log_stderr

    # @example
    #   Vedeu.keypress
    #
    # @!method keypress
    #   @see Vedeu::Mapper.keypress
    def_delegators Vedeu::Mapper, :keypress

    # @example
    #   Vedeu.menu
    #
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

    # @example
    #   Vedeu.renderer
    #   Vedeu.renderers
    #
    # @!method renderer
    #   @see Vedeu::Renderers#renderer
    # @!method renderers
    #   @see Vedeu::Renderers#renderers
    def_delegators Vedeu::Renderers, :renderer, :renderers

    # Return the height of the terminal running the client application.
    #
    # @example
    #   Vedeu.height
    #
    # @!method height
    #   @see Vedeu::Terminal#height
    def_delegators Vedeu::Terminal, :height

    # Return the width of the terminal running the client application.
    #
    # @example
    #   Vedeu.width
    #
    # @!method width
    #   @see Vedeu::Terminal#width
    def_delegators Vedeu::Terminal, :width

    # Instruct the terminal to resize. This will happen automatically as the
    # terminal recieves SIGWINCH signals.
    #
    # @example
    #   Vedeu.resize
    #
    # @!method resize
    #   @see Vedeu::Terminal#resize
    def_delegators Vedeu::Terminal, :resize

    # Measure the execution time of the code in the given block.
    #
    # @example
    #   Vedeu.timer do
    #     # ... some code here ...
    #   end
    #
    # @!method timer
    #   @see Vedeu::Timer.timer
    def_delegators Vedeu::Timer, :timer

    # Trigger an event by name.
    #
    # @example
    #   Vedeu.trigger(:name)
    #
    # @!method trigger
    #   @see Vedeu::Trigger.trigger
    def_delegators Vedeu::Trigger, :trigger

    # Exit the client application using Vedeu.
    #
    # @example
    #   Vedeu.exit
    #
    # @!method exit
    #   @see Vedeu::Application.stop
    def_delegators Vedeu::Application, :exit

    # Clear the entire terminal.
    #
    # @example
    #   Vedeu.clear
    #
    # @!method clear
    #   @see Vedeu::Terminal.clear
    def_delegators Vedeu::Terminal, :clear

    # Clear the interface with the given name.
    #
    # @example
    #   Vedeu.clear_by_name(name)
    #
    # @!method clear_by_name
    #   @see Vedeu::Clear::NamedInterface.render
    def_delegators Vedeu::Clear::NamedInterface, :clear_by_name

    # Clears the group of interfaces belonging to the given name.
    #
    # @example
    #   Vedeu.clear_by_group(name)
    #
    # @!method clear_by_group
    #   @see Vedeu::Clear::NamedGroup.render
    def_delegators Vedeu::Clear::NamedGroup, :clear_by_group

    # Hide the cursor for the interface of the given name.
    #
    # @example
    #   Vedeu.hide_cursor(name)
    #
    # @!method hide_cursor
    #   @see Vedeu::Cursor#hide
    def_delegators Vedeu::Cursor, :hide_cursor

    # Shows the cursor for the interface of the given name.
    #
    # @example
    #   Vedeu.show_cursor(name)
    #
    # @!method show_cursor
    #   @see Vedeu::Cursor#show
    def_delegators Vedeu::Cursor, :show_cursor

    # Toggle the visibility of the cursor with the given name.
    #
    # @example
    #   Vedeu.toggle_cursor(name)
    #
    # @!method toggle_cursor
    #   @see Vedeu::Cursor#hide
    #   @see Vedeu::Cursor#show
    def_delegators Vedeu::Cursor, :toggle_cursor

    # @!method hide_group
    #   @see Vedeu::Group#hide
    def_delegators Vedeu::Group, :hide_group

    # @!method show_group
    #   @see Vedeu::Group#show
    def_delegators Vedeu::Group, :show_group

    # Toggle the visibility of the group with the given name.
    #
    # @example
    #   Vedeu.toggle_group(name)
    #
    # @!method toggle_group
    #   @see Vedeu::Group#toggle
    def_delegators Vedeu::Group, :toggle_group

    # Hide the interface with the given name.
    #
    # @example
    #   Vedeu.hide_interface(name)
    #
    # @!method hide_interface
    #   @see Vedeu::Interface#hide
    def_delegators Vedeu::Interface, :hide_interface

    # Shows the interface with the given name.
    #
    # @example
    #   Vedeu.show_interface(name)
    #
    # @!method show_interface
    #   @see Vedeu::Interface#show
    def_delegators Vedeu::Interface, :show_interface

    # Toggle the visibility of the interface with the given name.
    #
    # @example
    #   Vedeu.toggle_interface(name)
    #
    # @!method toggle_interface
    #   @see Vedeu::Interface#toggle
    def_delegators Vedeu::Interface, :toggle_interface

  end # API

  extend API

end # Vedeu
