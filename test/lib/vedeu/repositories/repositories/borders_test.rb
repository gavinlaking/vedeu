require 'test_helper'

module Vedeu

  describe Borders do

    let(:described) { Vedeu::Borders }

    after { Vedeu.borders.reset! }

    it { described.must_respond_to(:borders) }

    describe '.reset!' do
      subject { described.reset! }

      before { described.stubs(:register) }

      it { described.must_respond_to(:reset) }

      it {
        described.expects(:register).with(Vedeu::Border)
        subject
      }
    end

  end # Borders

end # Vedeu
