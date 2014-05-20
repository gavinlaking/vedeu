module Vedeu
  class Interface
    def initialize(options = {})
      @options = options
    end

    def initial; end

    def main
      output

      input
    end

    def output
      Terminal.hide_cursor
    end

    def input
      Terminal.show_cursor
    end

    def width
      options[:width]  || Terminal.width
    end

    def height
      options[:height] || Terminal.height
    end

    private

    attr_reader :options
  end

  class Dummy < Interface; end
end
