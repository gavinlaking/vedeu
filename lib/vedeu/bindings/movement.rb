module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
    # @api public
    # {include:file:docs/events/movement.md}
    # :nocov:
    module Movement

      extend self

      # Setup events relating to movement.
      #
      # @return [void]
      def setup!
        cursor_down!
        cursor_left!
        cursor_origin!
        cursor_position!
        cursor_reposition!
        cursor_reset!
        cursor_right!
        cursor_up!
        geometry_down!
        geometry_left!
        geometry_right!
        geometry_up!
      end

      def cursor_down!
        Vedeu.bind(:_cursor_down_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :down, name)
        end
      end

      def cursor_left!
        Vedeu.bind(:_cursor_left_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :left, name)
        end
      end

      def cursor_origin!
        Vedeu.bind(:_cursor_origin_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :origin, name)
        end
      end

      # @todo This event queries Vedeu. Events should only be commands.
      def cursor_position!
        Vedeu.bind(:_cursor_position_) do |name|
          Vedeu.cursors.by_name(name).position
        end
      end

      def cursor_reposition!
        Vedeu.bind(:_cursor_reposition_) do |name, y, x|
          Vedeu::Reposition.to(Vedeu::Cursor, name, y, x)
        end
      end

      def cursor_reset!
        Vedeu.bind(:_cursor_reset_) do |name|
          Vedeu.trigger(:_cursor_origin_, name)
        end
      end

      def cursor_right!
        Vedeu.bind(:_cursor_right_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :right, name)
        end
      end

      def cursor_up!
        Vedeu.bind(:_cursor_up_) do |name|
          Vedeu::Move.by_name(Vedeu::Cursor, :up, name)
        end
      end

      def geometry_down!
        Vedeu.bind(:_geometry_down_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :down, name)
        end
      end

      def geometry_left!
        Vedeu.bind(:_geometry_left_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :left, name)
        end
      end

      def geometry_right!
        Vedeu.bind(:_geometry_right_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :right, name)
        end
      end

      def geometry_up!
        Vedeu.bind(:_geometry_up_) do |name|
          Vedeu::Move.by_name(Vedeu::Geometry, :up, name)
        end
      end

    end # Movement
    # :nocov:

  end # Bindings

end # Vedeu
