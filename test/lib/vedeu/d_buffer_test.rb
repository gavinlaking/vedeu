require_relative '../../test_helper'

module Vedeu
  describe DBuffer do
    let(:klass)  { DBuffer }
    let(:buffer) { klass.instance }
    let(:index)  {}
    let(:data)   {}

    describe '#update' do
      subject { buffer.update(index, data) }

      context 'when an line number is not provided' do
        it { subject.must_equal false }
      end

      context 'when the line content is not provided' do
        it { subject.must_equal false }
      end

      context 'when both the line number and content are provided' do
        let(:index) { 0 }
        let(:data)  { :some_data }

        it { subject.must_equal true }
      end
    end

    describe '#stale?' do
      subject { buffer.stale?(index, data) }

      context 'when an line number is not provided' do
        it { subject.must_equal false }
      end

      context 'when the line content is not provided' do
        it { subject.must_equal false }
      end

      context 'when both the line number and content are provided' do
        let(:index) { 0 }
        let(:data)  { :some_data }

        context 'when the line content is stale' do
          before { buffer.update(0, :old_data) }

          it { subject.must_equal true }
        end

        context 'when the line content is fresh' do
          before { buffer.update(0, :some_data) }

          it { subject.must_equal false }
        end
      end
    end

    describe '#debug' do
      before { klass.reset }

      subject { buffer.debug }

      context 'when the buffer is empty' do
        it 'returns the current buffer' do
          subject.must_equal([])
        end
      end

      context 'when the buffer contains data' do
        before { buffer.update(0, :some_data) }

        it 'returns the current buffer' do
          subject.must_equal([:some_data])
        end
      end
    end

    describe '#clear' do
      subject { buffer.clear }

      before { buffer.update(0, :some_data) }

      it 'returns a new buffer' do
        subject.debug.must_equal []

        subject.object_id.wont_equal buffer.object_id
      end
    end
  end
end
