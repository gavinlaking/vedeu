require_relative '../../../test_helper'

module Vedeu
  describe EventLoop do
    let(:described_class) { EventLoop }
    let(:defined) { mock }

    before do
      Interfaces.stubs(:defined).returns(defined)
      defined.stubs(:input).returns("stop")
      defined.stubs(:output).returns(NilClass)
    end

    describe '.start' do
      let(:subject) { described_class.start }

      it { subject.must_be_instance_of(NilClass) }
    end
  end
end
