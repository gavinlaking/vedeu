module Vedeu

  module Cursors

    # Control the visibility of the cursor for each interface/view.
    #
    module DSL

      # Set the cursor visibility on an interface.
      #
      # @param value [Boolean] Any value other than nil or false will
      #   evaluate
      #   to true.
      #
      # @example
      #   # Showing the cursor, each example is equivalent.
      #   #
      #   Vedeu.interface :my_interface do
      #     cursor true
      #
      #     # or...
      #
      #     cursor!
      #
      #     # ...
      #   end
      #
      #   # Hiding the cursor, each example is equivalent.
      #   #
      #   Vedeu.interface :my_interface do
      #     cursor false
      #
      #     # or...
      #
      #     no_cursor!
      #
      #     # ...
      #   end
      #
      #   # Can be set on a per-view basis also:
      #   #
      #   Vedeu.view :my_interface do
      #     cursor true # => Specify the visibility of the cursor when
      #                 #    the view is rendered.
      #
      #     # see other examples for other settings
      #   end
      #
      # @return [Vedeu::Cursors::Cursor]
      def cursor(value = true)
        boolean = value ? true : false

        model.cursor_visible = boolean

        Vedeu::Cursors::Cursor.store(name: model.name, visible: boolean)
      end

      # Set the cursor to visible for the interface or view.
      #
      # @return [Vedeu::Cursors::Cursor]
      def cursor!
        cursor(true)
      end
      alias_method :show_cursor!, :cursor!

      # Set the cursor to invisible for the interface or view.
      #
      # @return [Vedeu::Cursors::Cursor]
      def no_cursor!
        cursor(false)
      end
      alias_method :hide_cursor!, :no_cursor!

    end # DSL

  end # Cursors

end # Vedeu
