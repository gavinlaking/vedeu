module Vedeu
  class Compositor
    def self.write(output = [], options = {})
      new(output, options).write
    end

    def initialize(output = [], options = {})
      @output, @options = output, options
    end

    def write
      output.map do |line|
        print line
      end
      nil
    end

    private

    attr_reader :output

    def empty_line(line, width = Terminal.width)
      Esc.set_position(line, 0)
      print " " * width
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
