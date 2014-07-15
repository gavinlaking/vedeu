require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/queue'

module Vedeu
  describe Queue do
    describe '.dequeue' do
      it 'returns a NilClass when the queue is empty' do
        Queue.reset
        Queue.dequeue.must_be_instance_of(NilClass)
      end

      it 'returns the first entry added when the queue is not empty' do
        Queue.reset
        Queue.enqueue(:result)
        Queue.dequeue.must_be_instance_of(Symbol)
      end
    end

    describe '.enqueue' do
      it 'contains the enqueued item' do
        Queue.reset
        Queue.enqueue(:result).size.must_equal(1)
      end
    end

    describe '.enqueued?' do
      it 'returns true when the queue is not empty' do
        Queue.reset
        Queue.enqueue(:result)
        Queue.enqueued?.must_be_instance_of(TrueClass)
      end

      it 'returns false when the queue is empty' do
        Queue.reset
        Queue.enqueued?.must_be_instance_of(FalseClass)
      end
    end

    describe '.size' do
      it 'returns the size of the queue when the queue is empty' do
        Queue.reset
        Queue.size.must_equal(0)
      end

      it 'returns the size of the queue when the queue is not empty' do
        Queue.reset
        Queue.enqueue(:result).enqueue(:result)
        Queue.size.must_equal(2)
      end
    end

    describe '.clear' do
      it 'returns an empty array' do
        Queue.reset
        Queue.enqueue(:result)
        Queue.reset.must_be_empty
      end
    end

    describe '.view' do
      it 'returns the queue as a String when the queue is empty' do
        Queue.reset
        Queue.view.must_equal('[]')
      end

      it 'returns the queue as a String when the queue is not empty' do
        Queue.reset
        Queue.enqueue(:result)
        Queue.view.must_equal('[:result]')
      end
    end
  end
end
