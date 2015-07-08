module Vedeu

  module DSL

    # DSL for creating interfaces.
    #
    # @api public
    class Interface

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Text
      include Vedeu::DSL::Use

      # Returns an instance of Vedeu::DSL::Interface.
      #
      # @param model [Vedeu::DSL::Interface]
      # @param client [Object]
      # @return [Vedeu::DSL::Interface]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Allows the setting of a border for the interface.
      #
      # @example
      #   interface 'my_interface' do
      #     border do
      #       # ... see Vedeu::DSL::Border for DSL methods for borders.
      #     end
      #   end
      #
      # @param name [String] The name of the interface; this is already provided
      #   when we define the interface or view, setting it here is just
      #   mirroring functionality of {Vedeu::DSL::Border.border}.
      # @param block [Proc]
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Border]
      # @see Vedeu::DSL::Border
      def border(name = nil, &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        model_name = name ? name : model.name

        border_attrs = attributes.merge!(enabled: true,
                                         name:    model_name)

        Vedeu::Border.build(border_attrs, &block).store
      end

      # Applies the default border to the interface.
      #
      # @return [Vedeu::Border]
      def border!
        border do
          # adds default border
        end
      end

      # Set the cursor visibility on an interface.
      #
      # @param value [Boolean] Any value other than nil or false will evaluate
      #   to true.
      #
      # @example
      #   interface 'my_interface' do
      #     cursor  true  # => show the cursor for this interface
      #     cursor  :show # => both of these are equivalent to line above
      #     cursor!       #
      #     # ...
      #   end
      #
      #   interface 'my_interface' do
      #     cursor false # => hide the cursor for this interface
      #     cursor nil   # => as above
      #     # ...
      #   end
      #
      #   view 'my_interface' do
      #     cursor true # => Specify the visibility of the cursor when the view
      #     # ...       #    is rendered.
      #   end
      #
      # @return [Cursor]
      def cursor(value = true)
        boolean = value ? true : false

        Vedeu::Cursor.new(name: model.name, visible: boolean).store
      end

      # Set the cursor to visible for the interface.
      #
      # @return [Vedeu::Cursor]
      def cursor!
        cursor(true)
      end

      # To maintain performance interfaces can be delayed from refreshing too
      # often, the reduces artefacts particularly when resizing the terminal
      # screen.
      #
      # @param value [Fixnum|Float]
      #
      # @example
      #   interface 'my_interface' do
      #     delay 0.5 # interface will not update more often than every 500ms.
      #     # ...
      #   end
      #
      # @return [Fixnum|Float]
      def delay(value)
        model.delay = value
      end

      # Specify this interface as being in focus when the application starts.
      #
      # @note If multiple interfaces are defined, and this is included in each,
      #   then the last defined will be the interface in focus. However, this
      #   behaviour can be overridden:
      #
      #   ```ruby
      #   Vedeu.focus_by_name 'some_interface'
      #   ```
      #
      #   When the above is specified (outside of a `Vedeu.interface`
      #   declaration), the named interface will be focussed instead.
      #
      # @return [String] The name of the interface in focus.
      def focus!
        Vedeu::Focus.add(model.name, true) if present?(model.name)
      end

      # Define the geometry for an interface.
      #
      # @example
      #   interface 'my_interface' do
      #     geometry do
      #       # ... see Vedeu::DSL::Geometry for DSL methods for geometries.
      #     end
      #   end
      #
      # @param name [String] The name of the interface; this is already provided
      #   when we define the interface or view, setting it here is just
      #   mirroring functionality of {Vedeu::DSL::Geometry.geometry}.
      # @param block [Proc]
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Geometry]
      # @see Vedeu::DSL::Geometry
      def geometry(name = nil, &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        model_name = name ? name : model.name

        Vedeu::Geometry.build({ name: model_name }, &block).store
      end

      # Specify a group for an interface. Interfaces of the same group can be
      # targetted together; for example you may want to refresh multiple
      # interfaces at once.
      #
      # @example
      #   interface 'my_interface' do
      #     group 'main_screen'
      #     # ...
      #   end
      #
      # @param name [String] The name of the group to which this interface
      #   should belong.
      # @return [Vedeu::Group]
      def group(name)
        return false unless present?(name)

        model.group = name

        Vedeu.groups.by_name(name).add(model.name)
      end

      # @see Vedeu::DSL::Keymap.keymap
      def keymap(name = model.name, &block)
        Vedeu.keymap(name, &block)
      end
      alias_method :keys, :keymap

      # Specify multiple lines in a view.
      #
      # @param block [Proc]
      #
      # @example
      #   view 'my_interface' do
      #     lines do
      #       # ... see {Vedeu::DSL::Line} and {Vedeu::DSL::Stream}
      #     end
      #   end
      #
      #   view 'my_interface' do
      #     line do
      #       # ... see {Vedeu::DSL::Line} and {Vedeu::DSL::Stream}
      #     end
      #   end
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Line]
      def lines(&block)
        fail InvalidSyntax, 'block not given' unless block_given?

        model.add(model.member.build(attributes, &block))
      end
      alias_method :line, :lines

      # The name of the interface. Used to reference the interface throughout
      # your application's execution lifetime.
      #
      # @param value [String]
      #
      # @example
      #   interface do
      #     name 'my_interface'
      #     # ...
      #   end
      #
      # @return [String]
      def name(value)
        model.name = value
      end

      # Set the cursor to invisible for the interface.
      #
      # @return [Vedeu::Cursor]
      def no_cursor!
        cursor(false)
      end

      # Set the interface to visible.
      #
      # @return [void]
      def show!
        visible(true)
      end

      # Set the interface to invisible.
      #
      # @return [void]
      def hide!
        visible(false)
      end

      # Use a value from another model.
      #
      # @param name [String] The name of the interface model you wish to use a
      #   value from.
      # @return [Vedeu::Interface]
      def use(name)
        model.repository.by_name(name)
      end

      # Set the visibility of the interface.
      #
      # @param value [Boolean] Any value other than nil or false will evaluate
      #   to true.
      #
      # @example
      #   interface 'my_interface' do
      #     visible true  # => show the interface
      #     show!         # => as above
      #     # ...
      #   end
      #
      #   interface 'my_interface' do
      #     visible false # => hide the interface
      #     hide!         # => as above
      #     # ...
      #   end
      #
      #   view 'my_interface' do
      #     visible false
      #     # ...
      #   end
      #
      # @return [void]
      def visible(value = true)
        boolean = value ? true : false

        model.visible = boolean
      end

      # Set the zindex of the interface. This controls the render order of
      # interfaces. Interfaces with a lower zindex will render before those
      # with a higher zindex.
      #
      # @example
      #   --4-- # rendered last
      #   --3--
      #   --2--
      #   --1-- # rendered first
      #
      #   interface 'my_interface' do
      #     zindex 3
      #     # ...
      #   end
      #
      # @param value [Fixnum]
      # @return [void]
      def zindex(value)
        model.zindex = value
      end
      alias_method :z_index, :zindex
      alias_method :z,       :zindex

      protected

      # @!attribute [r] client
      # @return [Object]
      attr_reader :client

      # @!attribute [r] model
      # @return [Interface]
      attr_reader :model

      private

      # @return [Hash]
      def attributes
        {
          client: client,
          parent: model,
        }
      end

    end # Interface

  end # DSL

end # Vedeu
