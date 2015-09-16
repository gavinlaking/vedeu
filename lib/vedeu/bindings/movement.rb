module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
    module Movement

      extend self

      # Setup events relating to movement. This method is called by
      # Vedeu.
      #
      # @return [TrueClass]
      def setup!
        cursor_origin!
        cursor_position!
        cursor_reposition!
        directional!
      end

      private

      # See {file:docs/events.md#\_view__up_down_left_right_}
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

      # See {file:docs/events.md#\_cursor_origin_}
      def cursor_origin!
        Vedeu.bind(:_cursor_origin_) do |name|
          Vedeu.cursors.by_name(name).move_origin
        end

        Vedeu.bind_alias(:_cursor_reset_, :_cursor_origin_)
      end

      # See {file:docs/events.md#\_cursor_position_}
      def cursor_position!
        Vedeu.bind(:_cursor_position_) do |name|
          Vedeu.cursors.by_name(name).position
        end
      end

      # See {file:docs/events.md#\_cursor_reposition_}
      def cursor_reposition!
        Vedeu.bind(:_cursor_reposition_) do |name, y, x|
          Vedeu.cursors.by_name(name).reposition(y, x)

          Vedeu.trigger(:_clear_, name)
          Vedeu.trigger(:_refresh_, name)
          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

    end # Movement

  end # Bindings

end # Vedeu
