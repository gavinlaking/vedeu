module Vedeu

  # Facade which accesses various subsystems (like {Vedeu::Cursors},
  # {Vedeu::Offsets}) when a movement action occurs. The subsystems themselves
  # are responsible for ensuring integrity.
  #
  module Move

    extend self

    # @return []
    def down
      move(:y, 1)
    end

    # @return []
    def up
      move(:y, -1)
    end

    # @return []
    def right
      move(:x, 1)
    end

    # @return []
    def left
      move(:x, -1)
    end

    private

    # @param axis [Symbol]
    # @param value [Fixnum]
    # @return []
    def move(axis, value)
      move_cursor(axis, value)
      move_offset(axis, value)

      Vedeu.trigger(:_cursor_refresh_)
    end

    def move_cursor(axis, value)
      attributes = Cursors.find(name)

      attributes[axis] += value

      Cursors.update(attributes)
    end

    def move_offset(axis, value)
      offset = Offsets.find(name)

      attributes = offset.attributes
      attributes[axis] += value

      Offsets.update(attributes)
    end

    def name
      Focus.current
    end

    # System events which when called will move in the direction specified;
    # these will update the cursor position or content offset (scrolling)
    # according to the interface in focus.
    Vedeu.event(:_cursor_up_)      { up      }
    Vedeu.event(:_cursor_right_)   { right   }
    Vedeu.event(:_cursor_down_)    { down    }
    Vedeu.event(:_cursor_left_)    { left    }

  end # Move

end # Vedeu
