module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
    # :nocov:
    module Movement

      extend self

      # Setup events relating to movement. This method is called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        cursor_origin!
        cursor_position!
        cursor_reposition!
        directional!
      end

      private

      # Adjusts the position of the cursor or view.
      #
      # @example
      #   Vedeu.trigger(:_cursor_down_)
      #
      #   Vedeu.trigger(:_cursor_left_) # When a name is not given, the cursor
      #                                 # in the interface which is currently in
      #                                 # focus should move to the left.
      #
      #   Vedeu.trigger(:_cursor_left_, 'my_interface')
      #                                 # When a name is given, the cursor
      #                                 # instance belonging to this interface
      #                                 # moves to the left.
      #
      #   Vedeu.trigger(:_cursor_right_)
      #   Vedeu.trigger(:_cursor_up_)
      #
      #   Vedeu.trigger(:_cursor_origin_)                 # /or/
      #   Vedeu.trigger(:_cursor_origin_, 'my_interface')
      #                                 # Moves the cursor to the top left of
      #                                 # the named or current interface in
      #                                 # focus.
      #
      #   Vedeu.trigger(:_view_down_,  'my_interface')
      #   Vedeu.trigger(:_view_left_,  'my_interface')
      #   Vedeu.trigger(:_view_right_, 'my_interface')
      #   Vedeu.trigger(:_view_up_,    'my_interface')
      #
      #   Each of the :_view_* events has an alias, :_geometry_*
      #
      # @note
      #   The cursor or view may not be visible, but it will still move if
      #     requested.
      #   The cursor will not exceed the border or boundary of the interface, or
      #     boundary of the visible terminal.
      #   The cursor will move freely within the bounds of the interface,
      #     irrespective of content.
      #   The view will not exceed the boundary of the visible terminal.
      #   The view will move freely within the bounds of the interface,
      #     irrespective of content.
      #
      # @return [TrueClass]
      def directional!
        [:down, :left, :right, :up].each do |direction|
          Vedeu.bind("_cursor_#{direction}_".to_sym) do |name|
            Vedeu.cursors.by_name(name).send("move_#{direction}")

            Vedeu.trigger(:_refresh_cursor_, name)
          end

          Vedeu.bind("_view_#{direction}_".to_sym) do |name|
            Vedeu.geometries.by_name(name).send("move_#{direction}")

            Vedeu.trigger(:_clear_)
            Vedeu.trigger(:_refresh_)
            Vedeu.trigger(:_clear_, name)
            Vedeu.trigger(:_refresh_, name)
          end

          Vedeu.bind_alias("_geometry_#{direction}_".to_sym,
                           "_view_#{direction}_".to_sym)
        end
      end

      # This event moves the cursor to the interface origin; the top left corner
      # of the named interface.
      #
      # @example
      #   Vedeu.trigger(:_cursor_origin_, name)
      #   Vedeu.trigger(:_cursor_reset_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def cursor_origin!
        Vedeu.bind(:_cursor_origin_) do |name|
          Vedeu::Move.origin(Vedeu::Cursors::Cursor, name)
        end

        Vedeu.bind_alias(:_cursor_reset_, :_cursor_origin_)
      end

      # When triggered will return the current position of the cursor.
      #
      # @example
      #   Vedeu.trigger(:_cursor_position_, name)
      #
      # @todo This event queries Vedeu. Events should only be commands.
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def cursor_position!
        Vedeu.bind(:_cursor_position_) do |name|
          Vedeu.cursors.by_name(name).position
        end
      end

      # Moves the cursor to a relative position inside the interface.
      #
      # @example
      #   Vedeu.trigger(:_cursor_reposition_, name, y, x)
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def cursor_reposition!
        Vedeu.bind(:_cursor_reposition_) do |name, y, x|
          Vedeu.cursors.by_name(name).reposition(y, x)

          Vedeu.trigger(:_clear_, name)
          Vedeu.trigger(:_refresh_, name)
          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

    end # Movement
    # :nocov:

  end # Bindings

end # Vedeu
