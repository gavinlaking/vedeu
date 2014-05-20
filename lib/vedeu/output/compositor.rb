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
        clear_line(index)

        write_line(data)
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
            streams << Directive.enact(stream)
          end
        end
        container << streams.join
        streams = []
      end
      container
    end

    def clear_line(index)
      Terminal.clear_line(index)
    end

    def write_line(data)
      Terminal.output(data)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
