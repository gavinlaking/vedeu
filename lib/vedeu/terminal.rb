module Vedeu
  class Terminal
    # @return [Fixnum]
    def width
      size[1]
    end

    # @return [Fixnum]
    def height
      size[0]
    end

    private

    def size
      IO.console.winsize
    end
  end
end
