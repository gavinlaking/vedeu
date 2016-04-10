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
        model.cursor_visible = Vedeu::Boolean.coerce(value)

        Vedeu::Cursors::Cursor.store(name:    name,
                                     visible: Vedeu::Boolean.coerce(value))
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
