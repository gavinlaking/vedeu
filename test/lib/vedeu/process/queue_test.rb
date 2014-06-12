require_relative '../../../test_helper'

module Vedeu
  describe Queue do
    let(:described_class) { Queue }

    before do
      described_class.clear
    end

    describe '.dequeue' do
      let(:subject) { described_class.dequeue }

      context 'when the queue is empty' do
        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when the queue is not empty' do
        before { described_class.enqueue(:result) }

        it { subject.must_be_instance_of(Symbol) }
      end
    end

    describe '.enqueue' do
      let(:subject) { described_class.enqueue(result) }
      let(:result)  { :result }

      it { subject.must_be_instance_of(Module) }

      it { subject.size.must_equal(1) }
    end

    describe '.size' do
      let(:subject) { described_class.size }

      it { subject.must_be_instance_of(Fixnum) }
    end

    describe '.clear' do
      let(:subject) { described_class.clear }

      it { subject.must_be_instance_of(Array) }

      it { subject.must_be_empty }
    end

    describe '.view' do
      let(:subject) { described_class.view }

      it { subject.must_be_instance_of(String) }
    end
  end
end
