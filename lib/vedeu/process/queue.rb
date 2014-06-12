module Vedeu
  module Queue
    extend self

    def dequeue
      store.pop
    end

    def enqueue(result)
      store.unshift(result)
      self
    end

    def size
      store.size
    end

    def reset
      store.clear
    end

    private

    def store
      @store ||= Array.new
    end
  end
end
