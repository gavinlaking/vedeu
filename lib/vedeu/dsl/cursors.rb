module Vedeu

  module DSL

    module Cursors

      # Set the cursor visibility on an interface.
      #
      # @param value [Boolean] Any value other than nil or false will
      #   evaluate to true.
      # @return [Vedeu::Cursors::Cursor]
      def cursor(value = true)
        boolean = value ? true : false

        model.cursor_visible = boolean

        Vedeu::Cursors::Cursor.store(name: name, visible: boolean)
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

    end # Cursors

  end # DSL

end # Vedeu
