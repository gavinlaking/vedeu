# frozen_string_literal: true

module Vedeu

  module Interfaces

    # DSL for creating interfaces.
    #
    # @api private
    #
    class DSL

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Cursors
      include Vedeu::DSL::Border
      include Vedeu::DSL::Geometry
      include Vedeu::DSL::Presentation
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
        # @macro param_name
        # @macro param_block
        # @macro raise_requires_block
        # @macro raise_missing_required
        # @return [Vedeu::Interfaces::Interface]
        # @todo More documentation required.
        def interface(name, &block)
          raise Vedeu::Error::MissingRequired unless name
          raise Vedeu::Error::RequiresBlock unless block_given?

          attributes = { client: client(&block), name: name }

          interface = Vedeu::Interfaces::Interface
                      .build(attributes, &block)
                      .store

          add_buffers!(name)
          add_cursor!(name)
          add_editor!(name) if interface.editable?
          add_focusable!(name)
          add_keymap!(name)

          interface
        end

        private

        # Registers a set of buffers for the interface unless already
        # registered, and also adds interface's name to list of
        # focussable interfaces.
        #
        # @macro param_name
        # @see Vedeu::Buffers::Buffer
        # @return [Vedeu::Buffers::Buffer]
        def add_buffers!(name)
          Vedeu::Buffers::Buffer.new(name: name).store
        end

        # Registers a new cursor for the interface unless already
        # registered.
        #
        # @macro param_name
        # @return [Vedeu::Cursors::Cursor]
        def add_cursor!(name)
          Vedeu::Cursors::Cursor.store(name: name)
        end

        # Registers a new document with the interface.
        #
        # @macro param_name
        def add_editor!(name)
          Vedeu::Editor::Document.store(name: name)
        end

        # Registers interface name in focus list unless already
        # registered.
        #
        # @macro param_name
        # @return [Array<String|Symbol>]
        def add_focusable!(name)
          Vedeu::Models::Focus.add(name)
        end

        # Registers a new keymap for the interface unless already
        # registered.
        #
        # @macro param_name
        # @return [NilClass|Vedeu::Input::Keymap]
        def add_keymap!(name)
          Vedeu::Input::Keymap.store(name: name) unless keymap?(name)
        end

        # Returns the client object which called the DSL method.
        #
        # @macro param_block
        # @return [Object]
        def client(&block)
          eval('self', block.binding) if block_given?
        end

        private

        # @macro param_name
        # @return [Boolean]
        def keymap?(name)
          Vedeu.keymaps.registered?(name)
        end

      end # Eigenclass

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

      # Set whether the interface is editable.
      #
      # @note
      #   When an interface is made editable, then the cursor
      #   visibility will be set to visible.
      #
      # @param value [Boolean] Any value other than nil or false will
      #   evaluate to true.
      #
      # @example
      #   Vedeu.interface :my_interface do
      #     editable true # => The interface/view can be edited.
      #
      #     # or...
      #
      #     editable! # => Convenience method for above.
      #
      #     # ...
      #   end
      #
      #   Vedeu.interface :my_interface do
      #     editable false # => The interface/view cannot be edited.
      #
      #     # or...
      #
      #     editable # => as above
      #     # ...
      #   end
      #
      # @return [Boolean]
      def editable(value = true)
        boolean = value ? true : false

        cursor(true) if boolean

        model.editable = boolean
      end

      # Set the interface to be editable.
      #
      # @return [Boolean]
      def editable!
        editable(true)
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
      # @macro param_name
      # @return [Vedeu::Groups::Group]
      def group(name)
        return false unless present?(name)

        model.group = name

        Vedeu.groups.by_name(name).add(model.name)
      end

      # @macro param_name
      # @see Vedeu::Input::DSL.keymap
      def keymap(name = model.name, &block)
        Vedeu.keymap(name, &block)
      end
      alias keys keymap

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
      alias visible! show!

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
      # @macro param_name
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
      alias z_index zindex
      alias z       zindex

    end # DSL

  end # Interfaces

  # @api public
  # @!method interface
  #   @see Vedeu::Interfaces::DSL.interface
  def_delegators Vedeu::Interfaces::DSL,
                 :interface

end # Vedeu
