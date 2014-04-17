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

  def self.test_Vedue__Terminal(klass = Vedeu::Terminal)
    terminal = klass.new

    puts "Width:  #{terminal.width}"
    puts "Height: #{terminal.height}"
    puts
  end
end
