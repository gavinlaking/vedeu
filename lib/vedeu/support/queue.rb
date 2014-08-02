# Todo: mutation (queue)

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

    def reset
      store.clear
    end

    private

    def store
      @store ||= []
    end
  end
end
