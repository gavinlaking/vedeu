module Vedeu

  class VirtualTerminal

    def initialize(height, width)
      @height = height
      @width  = width
    end

    def cells
      Array.new(height) { Array.new(width) { Vedeu::Char.new } }
    end

    def height
      @height - 1
    end

    def read(y, x)
    end

    def width
      @width - 1
    end

    def write(y, x, data)
    end

  end # VirtualTerminal

end # Vedeu
