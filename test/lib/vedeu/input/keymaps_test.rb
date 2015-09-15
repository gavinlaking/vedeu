require 'test_helper'

module Vedeu

  module Input

    describe Keymaps do

      let(:described) { Vedeu::Input::Keymaps }

      it { described.must_respond_to(:keymaps) }

    end # Keymaps

  end # Input

end # Vedeu
