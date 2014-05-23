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
      Renderer.write(composition)
    end

    private

    attr_reader :output, :interface

    def composition
      container = []
      streams = []
      output.map do |line|
        line.each_with_index do |stream, index|
          streams << clear_line(index)

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
      [position(vy(index), vx), (" " * width), position(vy(index), vx)].join
    end

    def vx(index = 0)
      geometry.vx(index)
    end

    def vy(index = 0)
      geometry.vy(index)
    end

    def height
      geometry.height
    end

    def width
      geometry.width
    end

    def y
      geometry.y
    end

    def dy
      geometry.dy
    end

    def x
      geometry.x
    end

    def dx
      geometry.dx
    end

    def geometry
      interface.geometry
    end

    def position(y, x)
      Position.set(y, x)
    end
  end
end
