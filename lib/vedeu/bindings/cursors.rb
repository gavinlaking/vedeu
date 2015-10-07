module Vedeu

  module Bindings

    # System events relating to movement of cursors.
    #
    module Cursors

      extend self

      # Setup events relating to movement. This method is called by
      # Vedeu.
      #
      # @return [TrueClass]
      def setup!
        cursor_left!
        cursor_down!
        cursor_up!
        cursor_right!
        cursor_origin!
        cursor_position!
        cursor_reposition!
      end

      # @return [TrueClass]
      def setup_aliases!
        Vedeu.bind_alias(:_cursor_reset_, :_cursor_origin_)
      end

      private

      # :nocov:

      # See {file:docs/cursors.md}
      def cursor_left!
        Vedeu.bind(:_cursor_left_) do |name|
          Vedeu.cursors.by_name(name).move_left

          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

      # See {file:docs/cursors.md}
      def cursor_down!
        Vedeu.bind(:_cursor_down_) do |name|
          Vedeu.cursors.by_name(name).move_down

          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

      # See {file:docs/cursors.md}
      def cursor_up!
        Vedeu.bind(:_cursor_up_) do |name|
          Vedeu.cursors.by_name(name).move_up

          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

      # See {file:docs/cursors.md}
      def cursor_right!
        Vedeu.bind(:_cursor_right_) do |name|
          Vedeu.cursors.by_name(name).move_right

          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

      # See {file:docs/cursors.md}
      def cursor_origin!
        Vedeu.bind(:_cursor_origin_) do |name|
          Vedeu.cursors.by_name(name).move_origin
        end
      end

      # See {file:docs/cursors.md}
      def cursor_position!
        Vedeu.bind(:_cursor_position_) do |name|
          Vedeu.cursors.by_name(name).to_a
        end
      end

      # See {file:docs/cursors.md}
      def cursor_reposition!
        Vedeu.bind(:_cursor_reposition_) do |name, y, x|
          Vedeu.cursors.by_name(name).reposition(y, x)

          Vedeu.trigger(:_clear_view_, name)
          Vedeu.trigger(:_refresh_view_, name)
          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

      # :nocov:

    end # Cursors

  end # Bindings

end # Vedeu
