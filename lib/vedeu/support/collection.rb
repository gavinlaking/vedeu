module Vedeu
  class Collection
    include Singleton
    attr_writer :buffer

    def self.instance
      @instance ||= new
    end

    def self.reset
      @instance = new
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
      Collection.reset
    end

    private

    def buffer
      @buffer ||= []
    end
  end
end
