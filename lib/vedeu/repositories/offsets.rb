module Vedeu

  # Repository for storing and retrieving content offsets; i.e. scroll
  # position for a named interface.
  #
  # @api private
  module Offsets

    include Repository
    include Positional
    extend self

    # @return [Array]
    def down
      move(1, 0)
    end

    # @return [Array]
    def up
      move(-1, 0)
    end

    # @return [Array]
    def right
      move(0, 1)
    end

    # @return [Array]
    def left
      move(0, -1)
    end

    private

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Array]
    def move(y, x)
      find_or_create(Focus.current).move(y, x)

      Focus.refresh
    end

    # @return [Class]
    def entity
      Offset
    end

    # @return [Hash]
    def in_memory
      {}
    end

    # System events which when called will move in the direction specified;
    # these will update the cursor position or content offset (scrolling)
    # according to the interface in focus.
    Vedeu.event(:_cursor_up_)    { up    }
    Vedeu.event(:_cursor_right_) { right }
    Vedeu.event(:_cursor_down_)  { down  }
    Vedeu.event(:_cursor_left_)  { left  }

  end # Offsets

end # Vedeu
