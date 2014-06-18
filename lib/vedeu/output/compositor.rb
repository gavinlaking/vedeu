module Vedeu
  class UndefinedInterface < StandardError; end

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

      stream.each_with_index do |lines, index|
        if lines.size < height
          remaining = height - lines.size
          remaining.times { |i| lines << '' }
        end

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
      @_interface ||= InterfaceRepository.find_by_name(@interface)
    end
  end
end
