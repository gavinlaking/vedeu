# frozen_string_literal: true

module Vedeu

  module DSL

    # Provides DSL methods for Vedeu::Cursors::Cursor objects.
    #
    # @api public
    #
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
      alias show_cursor! cursor!

      # Set the cursor to invisible for the interface or view.
      #
      # @return [Vedeu::Cursors::Cursor]
      def no_cursor!
        cursor(false)
      end
      alias hide_cursor! no_cursor!

    end # Cursors

  end # DSL

end # Vedeu
