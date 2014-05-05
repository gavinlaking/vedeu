module Vedeu
  class Interface
    def initialize(options = {})
      @options = options
    end

    def run
      output

      input
    end

    def input
      Vedeu::Terminal.show_cursor
    end

    def output
      Vedeu::Terminal.hide_cursor

      #1.upto(height) { print "\n" }
    end

    def width
      options[:width]  || Vedeu::Terminal.width
    end

    def height
      options[:height] || Vedeu::Terminal.height
    end

    private

    attr_reader :options
  end

  class Dummy < Interface; end
end
