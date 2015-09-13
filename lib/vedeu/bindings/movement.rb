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

      # Move the cursor/view down, left, right or up by one character.
      #
      # @example
      #   Vedeu.trigger(:_cursor_down_, name)
      #   Vedeu.trigger(:_view_down_, name)
      #   Vedeu.trigger(:_geometry_down_, name)
      #   Vedeu.trigger(:_cursor_left_, name)
      #   Vedeu.trigger(:_view_left_, name)
      #   Vedeu.trigger(:_geometry_left_, name)
      #   Vedeu.trigger(:_cursor_right_, name)
      #   Vedeu.trigger(:_view_right_, name)
      #   Vedeu.trigger(:_geometry_right_, name)
      #   Vedeu.trigger(:_cursor_up_, name)
      #   Vedeu.trigger(:_view_up_, name)
      #   Vedeu.trigger(:_geometry_up_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Move
      def directional!
        [:down, :left, :right, :up].each do |direction|
          Vedeu.bind("_cursor_#{direction}_".to_sym) do |name|
            Vedeu::Move.send(direction, Vedeu::Cursor, name)
          end

          Vedeu.bind("_view_#{direction}_".to_sym) do |name|
            Vedeu::Move.send(direction, Vedeu::Geometry::Geometry, name)
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

    end # Movement
    # :nocov:

  end # Bindings

end # Vedeu
