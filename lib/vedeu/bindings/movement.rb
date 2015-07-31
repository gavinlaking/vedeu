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
        down!
        left!
        right!
        up!
      end

      private

      # Move the cursor/view down by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_down_, name)
      #   Vedeu.trigger(:_view_down_, name)
      #   Vedeu.trigger(:_geometry_down_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def down!
        Vedeu.bind(:_cursor_down_) do |name|
          Vedeu::Move.down(Vedeu::Cursor, name)
        end

        Vedeu.bind(:_view_down_) do |name|
          Vedeu::Move.down(Vedeu::Geometry, name)
        end

        Vedeu.bind_alias(:_geometry_down_, :_view_down_)
      end

      # Move the cursor/view left by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_left_, name)
      #   Vedeu.trigger(:_view_left_, name)
      #   Vedeu.trigger(:_geometry_left_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def left!
        Vedeu.bind(:_cursor_left_) do |name|
          Vedeu::Move.left(Vedeu::Cursor, name)
        end

        Vedeu.bind(:_view_left_) do |name|
          Vedeu::Move.left(Vedeu::Geometry, name)
        end

        Vedeu.bind_alias(:_geometry_left_, :_view_left_)
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
          Vedeu::Move.origin(Vedeu::Cursor, name)
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
          Vedeu::Reposition.to(Vedeu::Cursor, name, y, x)
        end
      end

      # Move the cursor/view right by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_right_, name)
      #   Vedeu.trigger(:_view_right_, name)
      #   Vedeu.trigger(:_geometry_right_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def right!
        Vedeu.bind(:_cursor_right_) do |name|
          Vedeu::Move.right(Vedeu::Cursor, name)
        end

        Vedeu.bind(:_view_right_) do |name|
          Vedeu::Move.right(Vedeu::Geometry, name)
        end

        Vedeu.bind_alias(:_geometry_right_, :_view_right_)
      end

      # Move the cursor/view up by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_up, name)
      #   Vedeu.trigger(:_view_up_, name)
      #   Vedeu.trigger(:_geometry_up_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def up!
        Vedeu.bind(:_cursor_up_) do |name|
          Vedeu::Move.up(Vedeu::Cursor, name)
        end

        Vedeu.bind(:_view_up_) do |name|
          Vedeu::Move.up(Vedeu::Geometry, name)
        end

        Vedeu.bind_alias(:_geometry_up_, :_view_up_)
      end

    end # Movement
    # :nocov:

  end # Bindings

end # Vedeu
