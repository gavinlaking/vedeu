module Vedeu
  module Queue
    extend self

    def dequeue
      store.pop
    end

    def enqueue(result)
      store.unshift(result)
      store
    end

    def size
      store.size
    end

    def clear
      store.clear
    end

    def view
      store.inspect
    end

    private

    def store
      @store ||= Array.new
    end
  end
end
