require_relative 'clear_interface'

module Vedeu
  class RenderInterface
    def self.call(interface)
      new(interface).render
    end

    def initialize(interface)
      @interface = interface
    end

    def render
      out = []
      out << ClearInterface.call(interface)
      interface.lines.each_with_index do |line, index|
        out << interface.origin(index)
        out << line.to_s
      end
      out.join
    end

    private

    attr_reader :interface
  end
end
