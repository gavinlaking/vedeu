require_relative '../../../test_helper'

module Vedeu
  describe EventLoop do
    let(:described_class) { EventLoop }
    let(:defined)         { mock }
    let(:subject)         { described_class.new }

    before do
      Interfaces.stubs(:defined).returns(defined)
      defined.stubs(:input).returns("stop")
      defined.stubs(:output).returns(NilClass)
    end

    it { subject.must_be_instance_of(EventLoop) }

    describe '.main_sequence' do
      let(:subject) { described_class.main_sequence }

      # it { subject.must_be_instance_of(NilClass) }
    end
  end
end
