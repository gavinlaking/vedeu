require_relative '../../../test_helper'

module Vedeu
  describe Collection do
    let(:klass)  { Collection }
    let(:collection) { klass.instance }
    let(:key)  {}
    let(:value)   {}

    describe '#update' do
      subject { collection.update(key, value) }

      context 'when a key is not provided' do
        it { subject.must_equal false }
      end

      context 'when the value is not provided' do
        it { subject.must_equal false }
      end

      context 'when both the key and value are provided' do
        let(:key) { 0 }
        let(:value)  { :some_data }

        it { subject.must_equal true }
      end
    end

    describe '#debug' do
      before { klass.reset }

      subject { collection.debug }

      context 'when the collection is empty' do
        it 'returns the current collection' do
          subject.must_equal({})
        end
      end

      context 'when the collection contains value' do
        before { collection.update("some_key", :some_value) }

        it 'returns the current collection' do
          subject.must_equal({some_key: :some_value})
        end
      end
    end

    describe '#clear' do
      subject { collection.clear }

      before { collection.update("some_key", :some_value) }

      it 'returns a new collection' do
        subject.debug.must_equal({})

        subject.object_id.wont_equal collection.object_id
      end
    end
  end
end
