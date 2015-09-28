module Vedeu

  module API

    # Provides the API to Vedeu. Methods therein, and classes
    # belonging to this module expose Vedeu's core functionality.
    #
    # These methods are used in a variety of ways, sometimes in
    # combination:
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
    module External

      extend Forwardable

      module_function

      # @!method configure
      #   @see Vedeu::Configuration.configure
      # @!method configuration
      #   @see Vedeu::Configuration.configuration
      def_delegators Vedeu::Configuration, :configure, :configuration

      # @!method cursor
      # @return [Vedeu::Cursors::Cursor]
      def_delegators Vedeu::Cursors::Repository, :cursor

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

      # @!method border
      #   @see Vedeu::Borders::DSL.border
      def_delegators Vedeu::Borders::DSL, :border

      # @!method geometry
      #   @see Vedeu::Geometry::DSL.geometry
      def_delegators Vedeu::Geometry::DSL, :geometry

      # @!method group
      #   @see Vedeu::Groups::DSL.group
      def_delegators Vedeu::Groups::DSL, :group

      # @!method keymap
      #   @see Vedeu::DSL::Keymap.keymap
      def_delegators Vedeu::DSL::Keymap, :keymap

      # @!method interface
      #   @see Vedeu::DSL::Interface.interface
      def_delegators Vedeu::DSL::Interface, :interface

      # @!method render
      #   @see Vedeu::DSL::View.render
      # @!method renders
      #   @see Vedeu::DSL::View.renders
      # @!method views
      #   @see Vedeu::DSL::View.views
      def_delegators Vedeu::DSL::View, :renders, :render, :views

      # @!method bind
      #   @see Vedeu::Events::Event.bind
      # @!method bound?
      #   @see Vedeu::Events::Event.bound?
      # @!method unbind
      #   @see Vedeu::Events::Event.unbind
      def_delegators Vedeu::Events::Event, :bind, :bound?, :unbind

      # @!method bind_alias
      #   @see Vedeu::Events::Aliases#bind_alias
      # @!method unbind_alias
      #   @see Vedeu::Events::Aliases#unbind_alias
      def_delegators Vedeu::Events::Aliases, :bind_alias, :unbind_alias

      # @!method focus
      #   @see Vedeu::Models::Focus#focus
      # @!method focus_by_name
      #   @see Vedeu::Models::Focus#focus_by_name
      # @!method focussed?
      #   @see Vedeu::Models::Focus#focussed?
      # @!method focus_next
      #   @see Vedeu::Models::Focus#focus_next
      # @!method focus_previous
      #   @see Vedeu::Models::Focus#focus_previous
      def_delegators Vedeu::Models::Focus, :focus, :focus_by_name, :focussed?,
                     :focus_next, :focus_previous

      # @!method log
      #   @see Vedeu::Logging::Log.log
      # @!method log_stdout
      #   @see Vedeu::Logging::Log.log_stdout
      # @!method log_stderr
      #   @see Vedeu::Logging::Log.log_stderr
      def_delegators Vedeu::Logging::Log, :log, :log_stdout, :log_stderr

      # @!method keypress
      #   @see Vedeu::Input::Mapper.keypress
      def_delegators Vedeu::Input::Mapper, :keypress

      # @!method menu
      #   @see Vedeu::Menus::Menu.menu
      def_delegators Vedeu::Menus::Menu, :menu

      # @!method goto
      #   @see Vedeu::Runtime::Router#goto
      def_delegators Vedeu::Runtime::Router, :goto

      # @!method height
      #   @see Vedeu::Terminal#height
      def_delegators Vedeu::Terminal, :height

      # @!method width
      #   @see Vedeu::Terminal#width
      def_delegators Vedeu::Terminal, :width

      # @!method trigger
      #   @see Vedeu::Events::Trigger.trigger
      def_delegators Vedeu::Events::Trigger, :trigger

      # @!method exit
      #   @see Vedeu::Runtime::Application.stop
      def_delegators Vedeu::Runtime::Application, :exit

      # @!method clear
      #   @see Vedeu::Terminal::Buffer#clear
      def_delegators Vedeu::Terminal::Buffer, :clear

      # @!method clear_by_name
      #   @see Vedeu::Clear::Interface.render
      def_delegators Vedeu::Clear::Interface, :clear_by_name

      # @!method clear_by_group
      #   @see Vedeu::Clear::Group.render
      def_delegators Vedeu::Clear::Group, :clear_by_group

      # @!method hide_cursor
      #   @see Vedeu::Cursors::Cursor#hide
      def_delegators Vedeu::Cursors::Cursor, :hide_cursor

      # @!method show_cursor
      #   @see Vedeu::Cursors::Cursor#show
      def_delegators Vedeu::Cursors::Cursor, :show_cursor

      # @!method toggle_cursor
      #   @see Vedeu::Cursors::Cursor#toggle
      def_delegators Vedeu::Cursors::Cursor, :toggle_cursor

      # @!method hide_group
      #   @see Vedeu::Groups::Group#hide
      def_delegators Vedeu::Groups::Group, :hide_group

      # @!method show_group
      #   @see Vedeu::Groups::Group#show
      def_delegators Vedeu::Groups::Group, :show_group

      # @!method toggle_group
      #   @see Vedeu::Groups::Group#toggle
      def_delegators Vedeu::Groups::Group, :toggle_group

      # @!method hide_interface
      #   @see Vedeu::Models::Interface#hide
      def_delegators Vedeu::Models::Interface, :hide_interface

      # @!method show_interface
      #   @see Vedeu::Models::Interface#show
      def_delegators Vedeu::Models::Interface, :show_interface

      # @!method toggle_interface
      #   @see Vedeu::Models::Interface#toggle
      def_delegators Vedeu::Models::Interface, :toggle_interface

    end # External

  end # API

  extend Vedeu::API::External

end # Vedeu
