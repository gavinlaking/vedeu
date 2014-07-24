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
      it 'contains the enqueued item' do
        Queue.enqueue(:result).size.must_equal(1)
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

    describe '.entries' do
      it 'returns an empty collection when the queue is empty' do
        Queue.entries.must_equal([])
      end

      it 'returns all the enqueue items when the queue is not empty' do
        Queue.enqueue(:queued_entry)
        Queue.entries.must_equal([:queued_entry])
      end
    end

    describe '.size' do
      it 'returns the size of the queue when the queue is empty' do
        Queue.size.must_equal(0)
      end

      it 'returns the size of the queue when the queue is not empty' do
        Queue.enqueue(:result).enqueue(:result)
        Queue.size.must_equal(2)
      end
    end

    describe '.clear' do
      it 'returns an empty array' do
        Queue.enqueue(:result)
        Queue.reset.must_be_empty
      end
    end

    describe '.view' do
      it 'returns the queue as a String when the queue is empty' do
        Queue.view.must_equal('[]')
      end

      it 'returns the queue as a String when the queue is not empty' do
        Queue.enqueue(:result)
        Queue.view.must_equal('[:result]')
      end
    end
  end
end
