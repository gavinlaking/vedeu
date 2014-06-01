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

    describe '.start' do
      let(:subject) { described_class.start }

      it { subject.must_be_instance_of(NilClass) }
    end

    describe '#stop' do
      let(:subject) { described_class.new.stop }

      it { subject.must_be_instance_of(FalseClass) }
    end

    describe '#tick' do
      let(:subject) { described_class.new.tick }

      it { skip }
    end
  end
end
