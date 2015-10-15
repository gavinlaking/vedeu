module Vedeu

  module Interfaces

    # DSL for creating interfaces.
    #
    class DSL

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Shared
      include Vedeu::DSL::Text
      include Vedeu::DSL::Use

      class << self

        include Vedeu::Common

        # Register an interface by name which will display output from
        # an event or a command. This provides the means for you to
        # define your the views of your application without their
        # content.
        #
        #   Vedeu.interface :my_interface do
        #     # ... some code
        #   end
        #
        # @param name [String|Symbol] The name of the interface. Used
        #   to reference the interface throughout your application's
        #   execution lifetime.
        # @param block [Proc] A set of attributes which define the
        #   features of the interface.
        # @raise [Vedeu::Error::RequiresBlock]
        # @return [Vedeu::Interfaces::Interface]
        # @todo More documentation required.
        def interface(name, &block)
          fail Vedeu::Error::RequiresBlock unless block_given?
          fail Vedeu::Error::MissingRequired,
               'name not given'.freeze unless present?(name)

          add_buffers!(name)
          add_cursor!(name)
          add_focusable!(name)

          attributes = { client: client(&block), name: name }

          Vedeu::Interfaces::Interface.build(attributes, &block).store
        end

        private

        # Registers a set of buffers for the interface unless already
        # registered, and also adds interface's name to list of
        # focussable interfaces.
        #
        # @param name [String|Symbol]
        # @see Vedeu::Buffers::Buffer
        # @return [Vedeu::Buffers::Buffer]
        def add_buffers!(name)
          Vedeu::Buffers::Buffer.new(name: name).store
        end

        # Registers a new cursor for the interface unless already
        # registered.
        #
        # @param name [String|Symbol]
        # @return [Vedeu::Cursors::Cursor]
        def add_cursor!(name)
          Vedeu::Cursors::Cursor.store(name: name)
        end

        # Registers interface name in focus list unless already
        # registered.
        #
        # @param name [String|Symbol]
        # @return [void]
        def add_focusable!(name)
          Vedeu::Models::Focus.add(name)
        end

        # Returns the client object which called the DSL method.
        #
        # @param block [Proc]
        # @return [Object]
        def client(&block)
          eval('self', block.binding)
        end

      end # Eigenclass

      # Set the cursor visibility on an interface.
      #
      # @param value [Boolean] Any value other than nil or false will
      #   evaluate
      #   to true.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     cursor  true  # => show the cursor for this interface
      #     # or...
      #     cursor  :show # => both of these are equivalent to line
      #                   #    above
      #     # or...
      #     cursor!       #
      #     # ...
      #   end
      #
      #   Vedeu.interface :my_interface do
      #     cursor false # => hide the cursor for this interface
      #     # or...
      #     cursor nil   # => as above
      #     # ...
      #   end
      #
      #   Vedeu.view :my_interface do
      #     cursor true # => Specify the visibility of the cursor when
      #                 #    the view is rendered.
      #     # ...
      #   end
      #
      # @return [Vedeu::Cursors::Cursor]
      def cursor(value = true)
        boolean = value ? true : false

        Vedeu::Cursors::Cursor.store(name: model.name, visible: boolean)
      end

      # Set the cursor to visible for the interface.
      #
      # @return [Vedeu::Cursors::Cursor]
      def cursor!
        cursor(true)
      end

      # To maintain performance interfaces can be delayed from
      # refreshing too often, the reduces artefacts particularly when
      # resizing the terminal screen.
      #
      # @param value [Fixnum|Float] Time in seconds. (0.5 = 500ms).
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     delay 0.5 # interface will not update more often than
      #               # every 500ms.
      #     # ...
      #   end
      #
      # @return [Fixnum|Float]
      def delay(value)
        model.delay = value
      end

      # Specify this interface as being in focus when the application
      # starts.
      #
      # @note If multiple interfaces are defined, and this is included
      #   in each, then the last defined will be the interface in
      #   focus. However, this behaviour can be overridden:
      #
      #   ```ruby
      #   Vedeu.focus_by_name :some_interface
      #   ```
      #
      #   When the above is specified (outside of a `Vedeu.interface`
      #   declaration), the named interface will be focussed instead.
      #
      # @return [Array<String>] A list of focusable interfaces.
      def focus!
        Vedeu::Models::Focus.add(model.name, true) if present?(model.name)
      end

      # Specify a group for an interface. Interfaces of the same group
      # can be targetted together; for example you may want to refresh
      # multiple interfaces at once.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     group :main_screen
      #     # ...
      #   end
      #
      # @param name [String|Symbol] The name of the group to which
      #   this interface should belong.
      # @return [Vedeu::Groups::Group]
      def group(name)
        return false unless present?(name)

        model.group = name

        Vedeu.groups.by_name(name).add(model.name)
      end

      # @param name [String|Symbol] The name of the interface to which
      #   this keymap should belong.
      # @see Vedeu::Input::DSL.keymap
      def keymap(name = model.name, &block)
        Vedeu.keymap(name, &block)
      end
      alias_method :keys, :keymap

      # The name of the interface. Used to reference the interface
      # throughout your application's execution lifetime.
      #
      # @param value [String|Symbol]
      #
      # @example
      #   Vedeu.interface do
      #     name :my_interface
      #     # ...
      #   end
      #
      # @return [String|Symbol]
      def name(value)
        model.name = value
      end

      # Set the cursor to invisible for the interface.
      #
      # @return [Vedeu::Cursors::Cursor]
      def no_cursor!
        cursor(false)
      end

      # Set the interface to visible.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     show!
      #
      #     # ... some code
      #   end
      #
      # @return [Boolean]
      def show!
        visible(true)
      end

      # Set the interface to invisible.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     # ... some code
      #   end
      #
      # @return [Boolean]
      def hide!
        visible(false)
      end

      # Use a value from another model.
      #
      # @param name [String|Symbol] The name of the interface model
      #   you wish to use a value from.
      # @return [Vedeu::Interfaces::Interface]
      def use(name)
        model.repository.by_name(name)
      end

      # Set the visibility of the interface.
      #
      # @param value [Boolean] Any value other than nil or false will
      #   evaluate to true.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     visible true  # => show the interface
      #     # or...
      #     show!         # => as above
      #     # ... some code
      #   end
      #
      #   Vedeu.interface :my_interface do
      #     visible false # => hide the interface
      #     # or...
      #     hide!         # => as above
      #     # ... some code
      #   end
      #
      #   Vedeu.view :my_interface do
      #     visible false
      #     # ... some code
      #   end
      #
      # @return [Boolean]
      def visible(value = true)
        boolean = value ? true : false

        model.visible = boolean
      end

      # Set the zindex of the interface. This controls the render
      # order of interfaces. Interfaces with a lower zindex will
      # render before those with a higher zindex.
      #
      # @example
      #   --4-- # rendered last
      #   --3--
      #   --2--
      #   --1-- # rendered first
      #
      #   Vedeu.interface :my_interface do
      #     zindex 3
      #     # ...
      #   end
      #
      # @param value [Fixnum]
      # @return [Fixnum]
      def zindex(value)
        model.zindex = value
      end
      alias_method :z_index, :zindex
      alias_method :z,       :zindex

    end # DSL

  end # Interfaces

  # @!method interface
  #   @see Vedeu::Interfaces::DSL.interface
  def_delegators Vedeu::Interfaces::DSL, :interface

end # Vedeu
