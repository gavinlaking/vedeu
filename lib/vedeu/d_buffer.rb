module Vedeu
  class DBuffer
    include Singleton
    attr_writer :buffer

    class << self
      def instance
        @instance ||= new
      end

      def reset
        @instance = new
      end
    end

    def update(index = nil, data = nil)
      return false unless index && data
      buffer[index] = data
      true
    end

    def stale?(index = nil, data = nil)
      return false unless index && data
      buffer[index] != data
    end

    def debug
      buffer
    end

    def clear
      DBuffer.reset
    end

    private

    def buffer
      @buffer ||= []
    end
  end
end
