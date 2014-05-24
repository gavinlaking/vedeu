require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:described_class)    { Application }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { {} }

    it { described_instance.must_be_instance_of(Application) }

    describe '.start' do
      let(:subject)    { described_class.start(options) }
      let(:interfaces) { mock("Interfaces", event_loop: nil,
                                            initial_state: nil) }

      before do
        Terminal.stubs(:open).yields(self)
        Terminal.stubs(:close)
        Interfaces.stubs(:defined).returns(interfaces)
      end

      it { subject.must_be_instance_of(NilClass) }
    end
  end
end
