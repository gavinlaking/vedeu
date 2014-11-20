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

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Offset
    end
    alias_method :entity, :model

    # @return [Hash]
    def in_memory
      {}
    end

    # System events which when called will move in the direction specified;
    # these will update the cursor position or content offset (scrolling)
    # according to the interface in focus.
    Vedeu.event(:_cursor_up_)    { Vedeu::Offsets.up    }
    Vedeu.event(:_cursor_right_) { Vedeu::Offsets.right }
    Vedeu.event(:_cursor_down_)  { Vedeu::Offsets.down  }
    Vedeu.event(:_cursor_left_)  { Vedeu::Offsets.left  }

  end # Offsets

end # Vedeu
