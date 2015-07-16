module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
    # @api public
    # :nocov:
    module Movement

      extend self

      # Setup events relating to movement. This method is called by Vedeu.
      #
      # @return [void]
      def setup!
        cursor_down!
        cursor_left!
        cursor_origin!
        cursor_position!
        cursor_reposition!
        cursor_right!
        cursor_up!
        geometry_down!
        geometry_left!
        geometry_right!
        geometry_up!
      end

      private

      # Move the cursor down by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_down_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def cursor_down!
        Vedeu.bind(:_cursor_down_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :down, name)
        end
      end

      # Move the cursor left by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_left_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def cursor_left!
        Vedeu.bind(:_cursor_left_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :left, name)
        end
      end

      # This event moves the cursor to the interface origin; the top left corner
      # of the named interface.
      #
      # @example
      #   Vedeu.trigger(:_cursor_origin_, name)
      #   Vedeu.trigger(:_cursor_reset_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def cursor_origin!
        Vedeu.bind(:_cursor_origin_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :origin, name)
        end
        Vedeu.bind(:_cursor_reset_) do |name|
          Vedeu.trigger(:_cursor_origin_, name)
        end
      end

      # When triggered will return the current position of the cursor.
      #
      # @example
      #   Vedeu.trigger(:_cursor_position_, name)
      #
      # @todo This event queries Vedeu. Events should only be commands.
      #
      # @return [void]
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
      # @return [void]
      # @see Vedeu::Move
      def cursor_reposition!
        Vedeu.bind(:_cursor_reposition_) do |name, y, x|
          Vedeu::Reposition.to(Vedeu::Cursor, name, y, x)
        end
      end

      # Move the cursor right by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_right_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def cursor_right!
        Vedeu.bind(:_cursor_right_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :right, name)
        end
      end

      # Move the cursor up by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_up, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def cursor_up!
        Vedeu.bind(:_cursor_up_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :up, name)
        end
      end

      # Move the geometry down by one character.
      #
      # @example
      #   Vedeu.trigger(:_geometry_down_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def geometry_down!
        Vedeu.bind(:_geometry_down_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :down, name)
        end
      end

      # Move the geometry left by one character.
      #
      # @example
      #   Vedeu.trigger(:_geometry_left_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def geometry_left!
        Vedeu.bind(:_geometry_left_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :left, name)
        end
      end

      # Move the geometry right by one character.
      #
      # @example
      #   Vedeu.trigger(:_geometry_right_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def geometry_right!
        Vedeu.bind(:_geometry_right_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :right, name)
        end
      end

      # Move the geometry up by one character.
      #
      # @example
      #   Vedeu.trigger(:_geometry_up_, name)
      #
      # @return [void]
      # @see Vedeu::Move
      def geometry_up!
        Vedeu.bind(:_geometry_up_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :up, name)
        end
      end

    end # Movement
    # :nocov:

  end # Bindings

end # Vedeu
