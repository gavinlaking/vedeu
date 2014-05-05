require_relative '../../test_helper'

module Vedeu
  describe Terminal do
    let(:klass)    { Terminal }
    let(:console)  { stub }

    before do
      IO.stubs(:console).returns(console)
      console.stubs(:winsize).returns([25, 80])
    end

    describe '.width' do
      subject { klass.width }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the width of the terminal' do
        subject.must_equal(80)
      end
    end

    describe '.height' do
      subject { klass.height }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the height of the terminal' do
        subject.must_equal(25)
      end
    end

    describe '.size' do
      subject { klass.size }

      it { subject.must_be_instance_of(Array) }

      it 'returns the width and height of the terminal' do
        subject.must_equal([25, 80])
      end
    end

    describe '.cooked' do
      subject { klass.cooked }

      it { skip }
    end

    describe '.raw' do
      subject { klass.raw }

      it { skip }
    end
  end
end
