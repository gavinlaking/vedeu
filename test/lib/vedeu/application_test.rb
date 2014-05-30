require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:described_class)    { Application }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { {} }

    it { described_instance.must_be_instance_of(Application) }

    describe '.start' do
      let(:subject) { described_class.start(options) }

      before do
        Terminal.stubs(:open).yields(self)
        Interfaces.stubs(:initial_state)
        EventLoop.stubs(:start)
        Terminal.stubs(:close)
      end

      it { subject.must_be_instance_of(NilClass) }
    end
  end
end
