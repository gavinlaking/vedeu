require_relative '../../test_helper'

module Vedeu
  describe Mask do
    let(:klass)    { Mask }
    let(:instance) { klass.new(fg, bg) }
    let(:fg)       { :fg }
    let(:bg)       { :bg }

    it { instance.must_be_instance_of(Mask) }

    describe '.[]' do
      subject { klass[fg, bg] }

      it { subject.must_be_instance_of(Array) }

      it 'returns a mask element' do
        subject.must_equal([:fg, :bg])
      end
    end
  end
end
