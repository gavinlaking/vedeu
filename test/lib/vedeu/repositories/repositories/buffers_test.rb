require 'test_helper'

module Vedeu

  describe Buffers do

    let(:described) { Vedeu::Buffers }
    let(:instance)  { described.buffers }

    it { described.must_respond_to(:buffers) }

    describe '#reset!' do
      subject { described.reset! }

      it { described.must_respond_to(:reset) }

      it {
        described.expects(:register).with(Vedeu::Buffer)
        subject
      }
    end

  end # Buffers

end # Vedeu
