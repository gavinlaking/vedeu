require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/queue'

module Vedeu
  describe Queue do
    let(:described_class) { Queue }

    describe '.dequeue' do
      let(:subject) { described_class.dequeue }

      context 'when the queue is empty' do
        it 'returns a NilClass' do
          subject.must_be_instance_of(NilClass)
        end
      end

      context 'when the queue is not empty' do
        before { described_class.enqueue(:result) }
        after  { described_class.clear }

        it 'returns the first entry added' do
          subject.must_be_instance_of(Symbol)
        end
      end
    end

    describe '.enqueue' do
      let(:subject) { described_class.enqueue(:result) }

      before { described_class.clear }
      after  { described_class.clear }

      it 'returns a Module' do
        subject.must_be_instance_of(Module)
      end

      it 'contains the enqueued item' do
        subject.size.must_equal(1)
      end
    end

    describe '.enqueued?' do
      let(:subject) { described_class.enqueued? }

      context 'when the queue is not empty' do
        before { described_class.enqueue(:result) }
        after  { described_class.clear }

        it 'returns a TrueClass' do
          subject.must_be_instance_of(TrueClass)
        end
      end

      context 'when the queue is empty' do
        it 'returns a FalseClass' do
          subject.must_be_instance_of(FalseClass)
        end
      end
    end

    describe '.size' do
      let(:subject) { described_class.size }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'when the queue is empty' do
        it 'returns the size of the queue' do
          subject.must_equal(0)
        end
      end

      context 'when the queue is not empty' do
        before { described_class.enqueue(:result).enqueue(:result) }
        after  { described_class.clear }

        it 'returns the size of the queue' do
          subject.must_equal(2)
        end
      end
    end

    describe '.clear' do
      let(:subject) { described_class.clear }

      before { described_class.enqueue(:result) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns an empty array' do
        subject.must_be_empty
      end
    end

    describe '.view' do
      let(:subject) { described_class.view }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'when the queue is empty' do
        it 'returns the queue as a String' do
          subject.must_equal('[]')
        end
      end

      context 'when the queue is not empty' do
        before { described_class.enqueue(:result) }
        after  { described_class.clear }

        it 'returns the queue as a String' do
          subject.must_equal('[:result]')
        end
      end
    end
  end
end
