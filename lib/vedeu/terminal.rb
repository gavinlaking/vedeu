module Vedeu
  class Terminal
    def width
      size[1]
    end

    def height
      size[0]
    end

    private

    def size
      IO.console.winsize
    end
  end
end
