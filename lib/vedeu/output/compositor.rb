module Vedeu
  class UndefinedInterface < StandardError; end

  class Compositor
    class << self
      def arrange(output = [], interface = :dummy)
        return if output.nil? || output.empty?

        if output.is_a?(Array)
          new(output, interface).arrange
        elsif output.is_a?(Hash)
          output.map do |i, o|
            new(o, i).arrange
          end
        end
      end
    end

    def initialize(output = [], interface = :dummy)
      @output, @interface = output, interface
    end

    def arrange
      Renderer.write(composition)
    end

    private

    def composition
      container = []
      streams   = []
      output.map do |line|
        line.each_with_index do |stream, index|
          streams << clear(index)
          streams << Directive.enact(stream)
        end
        container << streams.join
        streams = []
      end
      container
    end

    def clear(index)
      [origin(index), (' ' * width), origin(index)].join
    end

    def origin(index)
      target_interface.origin(index)
    end

    def width
      geometry.width
    end

    def geometry
      target_interface.geometry
    end

    def output
      return @output.split if @output.is_a?(String)
      @output
    end

    def target_interface
      raise UndefinedInterface if interface.nil?
      interface
    end

    def interface
      @_interface ||= InterfaceRepository.find_by_name(@interface)
    end
  end
end
