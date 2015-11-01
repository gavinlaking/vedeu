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

        Vedeu.log(message: "---------- #{self.class.name} #{__callee__} #{model.class.name} #{boolean}")

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
