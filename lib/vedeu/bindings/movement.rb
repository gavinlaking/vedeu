module Vedeu

  module Bindings

    # @api public
    module Movement

      # @see {Vedeu::Move}
      Vedeu.bind(:_cursor_down_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :down, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_cursor_left_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :left, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_cursor_origin_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :origin, name)
      end

      # Move the cursor to a relative position inside the interface.
      #
      # @todo
      #   - The content of the interface needs to be a consideration.
      #   - If the screen size changes, what should happen to the cursor.
      #   - How do we represent cursors which are deliberately positioned
      #     outside of the viewable area?
      #
      Vedeu.bind(:_cursor_reposition_) do |name, y, x|
        Vedeu::Reposition.to(Vedeu::Cursor, name, y, x)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_cursor_reset_) do |name|
        Vedeu.trigger(:_cursor_origin_, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_cursor_right_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :right, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_cursor_up_) do |name|
        Vedeu::Move.by_name(Vedeu::Cursor, :up, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_geometry_down_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :down, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_geometry_left_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :left, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_geometry_right_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :right, name)
      end

      # @see {Vedeu::Move}
      Vedeu.bind(:_geometry_up_) do |name|
        Vedeu::Move.by_name(Vedeu::Geometry, :up, name)
      end

    end # Movement

  end # Bindings

end # Vedeu
