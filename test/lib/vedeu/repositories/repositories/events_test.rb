require 'test_helper'

module Vedeu

  describe Events do

    let(:described) { Vedeu::Events }

    it { described.must_respond_to(:events) }

    describe '.reset!' do
      subject { described.reset! }

      it { described.must_respond_to(:reset) }

      it {
        described.expects(:new).with(Vedeu::EventCollection)
        subject
      }
    end

  end # Events

end # Vedeu
