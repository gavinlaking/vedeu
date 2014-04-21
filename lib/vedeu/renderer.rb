module Vedeu
  class Renderer
    include Enumerable

    # @param  buffer [Array]
    # @return        [Vedeu::Renderer]
    def initialize(buffer = [])
      @buffer = buffer
    end

    # @return [Enumerator]
    def each(&block)
      buffer.each(&block)
    end

    # @return [String]
    def render
      buffer.join
    end

    private

    attr_reader :buffer
  end
end
