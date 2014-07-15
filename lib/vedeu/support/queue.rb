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

    def enqueued?
      store.size > 0
    end

    def size
      store.size
    end

    def reset
      store.clear
    end

    def view
      store.inspect
    end

    private

    def store
      @store ||= []
    end
  end
end
