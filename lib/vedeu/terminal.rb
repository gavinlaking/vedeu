module Vedeu
  class Terminal
    class << self
      # @return [Hash]
      def size
        new.size
      end
    end

    # @return [Hash]
    def size
      { width: width, height: height }
    end

    # @return [Fixnum]
    def width
      dimensions[1]
    end

    # @return [Fixnum]
    def height
      dimensions[0]
    end

    private

    def dimensions
      IO.console.winsize
    end
  end
end
