require_relative '../../../test_helper'

module Vedeu
  describe Layer do
    let(:described_class)    { Layer }
    let(:described_instance) { described_class.new(index) }
    let(:index)              {}

    it 'returns a Layer instance' do
      described_instance.must_be_instance_of(Layer)
    end

    describe '#index' do
      let(:subject) { described_instance.index }

      it 'returns a Fixnum' do
        subject.must_be_instance_of(Fixnum)
      end

      context 'using a index' do
        let(:index) { 2 }

        it 'returns the index' do
          subject.must_equal(2)
        end
      end

      context 'using the default' do
        it 'returns the default' do
          subject.must_equal(0)
        end
      end
    end
  end
end
