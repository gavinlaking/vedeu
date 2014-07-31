require 'test_helper'
require 'vedeu/support/queue'

module Vedeu
  describe Queue do
    before { Queue.reset }

    describe '.dequeue' do
      it 'returns a NilClass when the queue is empty' do
        Queue.dequeue.must_be_instance_of(NilClass)
      end

      it 'returns the first entry added when the queue is not empty' do
        Queue.enqueue(:result)
        Queue.dequeue.must_be_instance_of(Symbol)
      end
    end

    describe '.enqueue' do
      it 'stores an item on the queue' do
        Queue.enqueue(:result)
        Queue.enqueued?.must_equal(true)
      end
    end

    describe '.enqueued?' do
      it 'returns true when the queue is not empty' do
        Queue.enqueue(:result)
        Queue.enqueued?.must_be_instance_of(TrueClass)
      end

      it 'returns false when the queue is empty' do
        Queue.enqueued?.must_be_instance_of(FalseClass)
      end
    end

    describe '.clear' do
      it 'returns an empty array' do
        Queue.enqueue(:result)
        Queue.reset.must_be_empty
      end
    end
  end
end
