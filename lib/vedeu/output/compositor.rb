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
      parsed.each_with_index do |data, index|
        render(data, index)
      end.join("\n")
    end

    private

    attr_reader :output

    def parsed
      container = []
      streams = []
      output.map do |line|
        line.map do |stream|
          if stream.is_a?(String)
            streams << stream
          else
            streams << Vedeu::Directive.enact(stream)
          end
        end
        container << streams.join
        streams = []
      end
      container
    end

    def render(data, index)
      Terminal.output(Position.set(index, 0))
      Terminal.output(" " * width)
      Terminal.output(data)
    end

    def width
      Terminal.width
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
