require_relative '../../test_helper'

module Vedeu
  describe Terminal do
    let(:klass)    { Terminal }
    let(:instance) { klass.new }
    let(:console)  { stub }

    before do
      IO.stubs(:console).returns(console)
      console.stubs(:winsize).returns([25, 80])
    end

    it { instance.must_be_instance_of(Vedeu::Terminal) }

    describe '#width' do
      subject { instance.width }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the width of the terminal' do
        subject.must_equal(80)
      end
    end

    describe '#height' do
      subject { instance.height }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the height of the terminal' do
        subject.must_equal(25)
      end
    end
  end
end
