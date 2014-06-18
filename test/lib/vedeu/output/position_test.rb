require_relative '../../../test_helper'

module Vedeu
  describe Position do
    let(:described_class)    { Position }
    let(:described_instance) { described_class.new }

    it 'returns a Position instance' do
      described_instance.must_be_instance_of(Position)
    end

    describe '.set' do
      let(:subject) { described_class.set }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'when no coordinates are provided' do
        it 'returns a position escape sequence' do
          subject.must_equal('')
        end
      end

      context 'when coordinates are provided' do
        let(:subject) { described_class.set(y, x) }
        let(:y)       { 12 }
        let(:x)       { 19 }

        it 'returns a position escape sequence' do
          subject.must_equal("\e[12;19H")
        end
      end
    end

    describe '.reset' do
      let(:subject) { described_class.reset }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns a position escape sequence' do
        subject.must_equal("\e[1;1H")
      end
    end
  end
end
