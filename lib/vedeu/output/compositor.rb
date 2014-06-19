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
      streams   = []

      container << colour.set

      if stream.size < height
        remaining = height - stream.size
        remaining.times { |i| stream << [''] }
      end

      stream.each_with_index do |lines, index|
        streams << clear(index)

        lines.each do |data|
          streams << Directive.enact(interface, data)
        end

        container << streams.join
        streams = []
      end

      container << colour.reset
      container << cursor

      container
    end

    def clear(index)
      [origin(index), (' ' * width), origin(index)].join
    end

    def origin(index)
      geometry.origin(index)
    end

    def height
      geometry.height
    end

    def width
      geometry.width
    end

    def geometry
      interface.geometry
    end

    def colour
      interface.colour
    end

    def cursor
      interface.cursor
    end

    def interface
      @_interface ||= InterfaceRepository.find(@interface)
    end
  end
end
