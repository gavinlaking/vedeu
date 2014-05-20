require_relative '../../../test_helper'

module Vedeu
  describe Position do
    let(:described_class)    { Position }
    let(:instance) { described_class.new }

    it { instance.must_be_instance_of(Position) }

    describe '.set' do
      subject { described_class.set }

      it { subject.must_be_instance_of(String) }

      context 'when no coordinates are provided' do
        it 'returns a position escape sequence' do
          subject.must_equal("\e[1;1H")
        end
      end

      context 'when coordinates are provided' do
        let(:y) { 12 }
        let(:x) { 19 }

        subject { described_class.set(y, x) }

        it 'returns a position escape sequence' do
          subject.must_equal("\e[13;20H")
        end
      end
    end
  end
end
