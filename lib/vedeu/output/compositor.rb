module Vedeu
  class Compositor
    class << self
      def write(output = [], interface = Dummy)
        return if output.nil? || output.empty?

        new(output, interface).write
      end
    end

    def initialize(output = [], interface = Dummy)
      @output, @interface = output, interface
    end

    def write
      parsed.each_with_index do |data, index|
        clear_line(index)

        write_line(data)
      end.join("\n")
    end

    private

    attr_reader :output, :interface

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
      if interface.is_a?(Dummy)
        Terminal.clear_line(index)
      else

      end
    end

    def write_line(data)
      Terminal.output(data)
    end
  end
end
