module Vedeu
  class Compositor
    class << self
      def arrange(output = {})
        output.map do |interface, stream|
          new({ interface: interface, stream: stream }).arrange
        end
      end
    end

    def initialize(attributes = {})
      @attributes = attributes || {}
      @interface  = attributes[:interface]
      @stream     = attributes[:stream]
    end

    def arrange
      interface.enqueue(composition)
    end

    private

    attr_reader :attributes, :stream

    def composition
      container = []

      pad_stream

      stream.each_with_index do |lines, index|
        line = [interface.colour.set, clear(index)]

        lines.each do |data|
          line << Directive.enact(interface, data)
        end

        line << interface.colour.reset << interface.cursor

        container << line.join
      end

      container
    end

    def pad_stream
      if stream.size < height
        remaining = height - stream.size
        remaining.times { |i| stream << [''] }
      end
    end

    def clear(index)
      [origin(index), (' ' * width), origin(index)].join
    end

    def origin(index)
      interface.geometry.origin(index)
    end

    def height
      interface.geometry.height
    end

    def width
      interface.geometry.width
    end

    def stream
      @_stream ||= if @stream.is_a?(String)
        [@stream.split("\n")]
      else
        @stream
      end
    end

    def interface
      @_interface ||= InterfaceRepository.find(@interface)
    end
  end
end
