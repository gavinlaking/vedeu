module Vedeu

  # Facade which accesses various subsystems (like {Vedeu::Cursors},
  # {Vedeu::Offsets}) when a movement action occurs. The subsystems themselves
  # are responsible for ensuring integrity.
  #
  module Move

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
    # @return [Array] An array of the results of the events associated with
    #   +:_cursor_refresh_+.
    def move(y, x)
      [Cursors, Offsets].each do |repository|
        repository.move(y, x)
      end

      Vedeu.trigger(:_cursor_refresh_)
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
