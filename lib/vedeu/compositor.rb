module Vedeu
  class Compositor
    def initialize
    end

    private

    def empty_line(line, width = Terminal.width)
      Esc.set_position(line, 0)
      print " " * width
    end
  end
end
