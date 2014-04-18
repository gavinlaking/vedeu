module Vedeu
  class Terminal
    # @return [Integer]
    def width
      size[1]
    end

    # @return [Integer]
    def height
      size[0]
    end

    private

    def size
      IO.console.winsize
    end
  end
end
