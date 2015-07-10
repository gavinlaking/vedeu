module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
    # @api public
    # {include:file:docs/events/movement.md}
    module Movement

      Vedeu.bind(:_cursor_down_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :down, name)
      end

      Vedeu.bind(:_cursor_left_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :left, name)
      end

      Vedeu.bind(:_cursor_origin_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :origin, name)
      end

      # @todo This event queries Vedeu. Events should only be commands.
      Vedeu.bind(:_cursor_position_) do |name|
        Vedeu.cursors.by_name(name).position
      end

      Vedeu.bind(:_cursor_reposition_) do |name, y, x|
        Vedeu::Reposition.to(Vedeu::Cursor, name, y, x)
      end

      Vedeu.bind(:_cursor_reset_) do |name|
        Vedeu.trigger(:_cursor_origin_, name)
      end

      Vedeu.bind(:_cursor_right_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :right, name)
      end

      Vedeu.bind(:_cursor_up_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :up, name)
      end

      Vedeu.bind(:_geometry_down_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :down, name)
      end

      Vedeu.bind(:_geometry_left_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :left, name)
      end

      Vedeu.bind(:_geometry_right_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :right, name)
      end

      Vedeu.bind(:_geometry_up_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :up, name)
      end

    end # Movement

  end # Bindings

end # Vedeu
