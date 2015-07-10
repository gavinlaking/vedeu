require 'test_helper'

module Vedeu

  describe Menus do

    let(:described) { Vedeu::Menus }

    it { described.must_respond_to(:menus) }

    describe '.reset!' do
      subject { described.reset! }

      it { described.must_respond_to(:reset) }

      it {
        described.expects(:register).with(Vedeu::Menu)
        subject
      }
    end

  end # Menus

end # Vedeu
