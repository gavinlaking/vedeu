module Vedeu
  class Output
    class << self
      def render
        new.render
      end
    end

    def initialize; end

    def render
      InterfaceRepository.update.map do |interface|
        interface.map { |stream| Terminal.output(stream) unless stream.nil? }
      end
    end
  end
end
