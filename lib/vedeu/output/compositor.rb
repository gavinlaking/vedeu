module Vedeu
  class Compositor
    class << self
      def write(output = [], options = {})
        return if output.nil? || output.empty?

        new(output, options).write
      end
    end

    def initialize(output = [], options = {})
      @output, @options = output, options
    end

    def write
      parsed.map do |line|
        #print line
      end
      parsed.join("\n")
    end

    private

    attr_reader :output

    def parsed
      container = []
      streams = []
      output.map do |line|
        line.map do |stream|
          streams << if stream.is_a?(Array)
            Mask.set(stream)
          elsif stream.is_a?(Symbol)
            # Esc.set_style(stream)
            Mask.set(Array(stream))
          else
            stream
          end
        end
        container << streams.join
        streams = []
      end
      container
    end

    def empty_line(index, width = Terminal.width)
      print Esc.set_position(index, 0)
      print " " * width
      print Esc.set_position(index, 0)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
