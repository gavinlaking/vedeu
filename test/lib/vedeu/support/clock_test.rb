require_relative '../../../test_helper'

module Vedeu
  describe Clock do
    let(:klass)    { Clock }
    let(:instance) { klass.new }
    let(:options)  { { seconds: 0.001 } }
    let(:block)    {}

    it { instance.must_be_instance_of(Clock) }

    describe '#tick' do
      context 'when a block is given' do
        subject { klass.start(options) {} }

        it { proc { subject }.must_raise(OutOfTimeError) }
      end

      context 'when no block is given' do
        subject { klass.start(options) }

        it { proc { subject }.must_raise(OutOfWorkError) }
      end
    end
  end
end
