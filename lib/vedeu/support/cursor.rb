module Vedeu
  class Cursor

    attr_reader :top, :bottom, :left, :right, :cursor_x, :cursor_y

    # @param attributes [Hash]
    # @return [Cursor]
    def initialize(attributes = {})
      @attributes = attributes

      @top        = attributes.fetch(:top)
      @bottom     = attributes.fetch(:bottom)
      @left       = attributes.fetch(:left)
      @right      = attributes.fetch(:right)
      @cursor_y   = attributes.fetch(:cursor_y, @top)
      @cursor_x   = attributes.fetch(:cursor_x, @left)
    end

    # @return [Array]
    def position
      [ @cursor_y, @cursor_x ]
    end

    # @return [Cursor]
    def move_up
      unless @cursor_y == top || @cursor_y - 1 < top
        @cursor_y -= 1
      end

      self
    end

    # @return [Cursor]
    def move_down
      unless @cursor_y == bottom || @cursor_y + 1 > bottom
        @cursor_y += 1
      end

      self
    end

    # @return [Cursor]
    def move_left
      unless @cursor_x == left || @cursor_x - 1 < left
        @cursor_x -= 1
      end

      self
    end

    # @return [Cursor]
    def move_right
      unless @cursor_x == right || @cursor_x + 1 > right
        @cursor_x += 1
      end

      self
    end

  end
end
