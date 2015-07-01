require 'test_helper'

module Vedeu

  describe Keymaps do

    let(:described) { Vedeu::Keymaps }

    it { described.must_respond_to(:keymaps) }

    describe '.reset!' do
      subject { described.reset! }

      it {
        described.expects(:register).with(Vedeu::Keymap)
        subject
      }
    end

  end # Keymaps

end # Vedeu
