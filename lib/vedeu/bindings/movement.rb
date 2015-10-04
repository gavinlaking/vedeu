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

      # @return [TrueClass]
      def setup_aliases!
        %w(down left right up).each do |direction|
          Vedeu.bind_alias(:"_geometry_#{direction}_",
                           :"_view_#{direction}_")
        end

        Vedeu.bind_alias(:_cursor_reset_, :_cursor_origin_)
      end

      private

      # :nocov:

      # See {file:docs/events/movement.md#\_cursor_up_down_left_right_}
      def directional!
        %w(down left right up).each do |direction|
          Vedeu.bind(:"_cursor_#{direction}_") do |name|
            Vedeu.cursors.by_name(name).send("move_#{direction}")

            Vedeu.trigger(:_refresh_cursor_, name)
          end

          Vedeu.bind(:"_view_#{direction}_") do |name|
            Vedeu.geometries.by_name(name).send("move_#{direction}")

            Vedeu.trigger(:_clear_)
            Vedeu.trigger(:_refresh_)
            Vedeu.trigger(:_clear_view_, name)
            Vedeu.trigger(:_refresh_view_, name)
          end
        end
      end

      # See {file:docs/events/movement.md#\_cursor_origin_}
      def cursor_origin!
        Vedeu.bind(:_cursor_origin_) do |name|
          Vedeu.cursors.by_name(name).move_origin
        end
      end

      # See {file:docs/events/movement.md#\_cursor_position_}
      def cursor_position!
        Vedeu.bind(:_cursor_position_) do |name|
          Vedeu.cursors.by_name(name).position
        end
      end

      # See {file:docs/events/movement.md#\_cursor_reposition_}
      def cursor_reposition!
        Vedeu.bind(:_cursor_reposition_) do |name, y, x|
          Vedeu.cursors.by_name(name).reposition(y, x)

          Vedeu.trigger(:_clear_view_, name)
          Vedeu.trigger(:_refresh_view_, name)
          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

      # :nocov:

    end # Movement

  end # Bindings

end # Vedeu
