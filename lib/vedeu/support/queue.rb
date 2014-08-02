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
      store.any?
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
