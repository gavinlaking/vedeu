module Vedeu
  class UndefinedInterface < StandardError; end

  class Compositor
    class << self
      def arrange(output = [], interface = 'dummy')
        return if output.nil? || output.empty?

        if output.is_a?(Array)
          new(output, interface).arrange
        elsif output.is_a?(Hash)
          output.map { |i, o| new(o, i).arrange }
        end
      end
    end

    def initialize(output = [], interface = 'dummy')
      @output    = output || []
      @interface = interface
    end

    def arrange
      Renderer.write(composition)
    end

    private

    def composition
      container = []
      streams   = []

      container << colour.set

      output.map do |lines|
        if lines.size < geometry.height
          remaining = geometry.height - lines.size
          remaining.times { |i| lines << "" }
        end

        lines.each_with_index do |stream, index|
          streams << clear(index)
          streams << Directive.enact(stream)
        end

        container << streams.join
        streams = []
      end

      container << colour.reset

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

    def output
      return @output.split if @output.is_a?(String)
      @output
    end

    def interface
      @_interface ||= InterfaceRepository.find_by_name(@interface)
    end
  end
end
