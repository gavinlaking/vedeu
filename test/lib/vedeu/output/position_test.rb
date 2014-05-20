require_relative '../../../test_helper'

module Vedeu
  describe Position do
    let(:klass)    { Position }
    let(:instance) { klass.new }

    it { instance.must_be_instance_of(Position) }

    describe '.set' do
      subject { klass.set }

      it { subject.must_be_instance_of(String) }

      context 'when no coordinates are provided' do
        it 'returns a position escape sequence' do
          subject.must_equal("\e[1;1H")
        end
      end

      context 'when coordinates are provided' do
        let(:y) { 12 }
        let(:x) { 19 }

        subject { klass.set(y, x) }

        it 'returns a position escape sequence' do
          subject.must_equal("\e[13;20H")
        end
      end
    end
  end
end
