module Vedeu

  # Vedeu's internal API methods provide convenient ways to access
  # Vedeu's internals. They are not supposed to be used by client
  # applications as they have limited value there.
  #
  module InternalAPI

    extend Forwardable

    module_function

    # Manipulate the repository of background colours.
    #
    # @example
    #   Vedeu.background_colours
    #
    # @!method background_colours
    # @return [Vedeu::Colours::Backgrounds]
    def_delegators Vedeu::Colours::Backgrounds, :background_colours

    # Manipulate the repository of borders.
    #
    # @example
    #   Vedeu.borders
    #
    # @!method borders
    # @return [Vedeu::Borders::Repository]
    def_delegators Vedeu::Borders::Repository, :borders

    # Manipulate the repository of buffers.
    #
    # @example
    #   Vedeu.buffers
    #
    # @!method buffers
    # @return [Vedeu::Buffers::Repository]
    def_delegators Vedeu::Buffers::Repository, :buffers

    # Manipulate the repository of cursors.
    #
    # @example
    #   Vedeu.cursors
    #
    # @!method cursors
    # @return [Vedeu::Cursors::Repository]
    def_delegators Vedeu::Cursors::Repository, :cursors

    # Allow debugging via the creation of stack traces courtesy of
    # ruby-prof.
    #
    # @example
    #   Vedeu.debug
    #
    # @!method debug
    # @return [Vedeu::Logging::Debug]
    def_delegators Vedeu::Logging::Debug, :debug

    # Manipulate the repository of documents.
    #
    # @example
    #   Vedeu.documents
    #
    # @!method documents
    # @return [Vedeu::Editor::Documents]
    def_delegators Vedeu::Editor::Documents, :documents

    # Manipulate the repository of events.
    #
    # @example
    #   Vedeu.events
    #
    # @!method events
    # @return [Vedeu::Events::Repository]
    def_delegators Vedeu::Events::Repository, :events

    # Manipulate the repository of foreground colours.
    #
    # @example
    #   Vedeu.foreground_colours
    #
    # @!method foreground_colours
    # @return [Vedeu::Colours::Foregrounds]
    def_delegators Vedeu::Colours::Foregrounds, :foreground_colours

    # Manipulate the repository of geometries.
    #
    # @example
    #   Vedeu.geometries
    #
    # @!method geometries
    # @return [Vedeu::Geometry::Repository]
    def_delegators Vedeu::Geometry::Repository, :geometries

    # Manipulate the repository of groups.
    #
    # @example
    #   Vedeu.groups
    #
    # @!method groups
    # @return [Vedeu::Models::Groups]
    def_delegators Vedeu::Models::Groups, :groups

    # Manipulate the repository of interfaces.
    #
    # @example
    #   Vedeu.interfaces
    #
    # @!method interfaces
    # @return [Vedeu::Models::Interfaces]
    def_delegators Vedeu::Models::Interfaces, :interfaces

    # Manipulate the repository of keymaps.
    #
    # @example
    #   Vedeu.keymaps
    #
    # @!method keymaps
    # @return [Vedeu::Input::Keymaps]
    def_delegators Vedeu::Input::Keymaps, :keymaps

    # Manipulate the repository of menus.
    #
    # @example
    #   Vedeu.menus
    #
    # @!method menus
    # @return [Vedeu::Menus::Repository]
    def_delegators Vedeu::Menus::Repository, :menus

    # Manipulate the internal flags.
    #
    # @!method ready?
    # @!method ready!
    # @return [Boolean]
    def_delegators Vedeu::Runtime::Flags, :ready?, :ready!

    # @example
    #   Vedeu.renderer
    #   Vedeu.renderers
    #
    # @!method renderer
    #   @see Vedeu::Renderers#renderer
    # @!method renderers
    #   @see Vedeu::Renderers#renderers
    def_delegators Vedeu::Renderers, :renderer, :renderers

    # Instruct the terminal to resize. This will happen automatically
    # as the terminal recieves SIGWINCH signals.
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
    #   @see Vedeu::Logging::Timer.timer
    def_delegators Vedeu::Logging::Timer, :timer

  end # InternalAPI

  extend InternalAPI

end # Vedeu
