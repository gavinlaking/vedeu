require 'test_helper'

module Vedeu

  module Bindings

    describe 'Bindings' do
      before do
        Vedeu.stubs(:log)
      end

      it { Vedeu.bound?(:_drb_input_).must_equal(true) }
      it { Vedeu.bound?(:_cleanup_).must_equal(true) }
      it { Vedeu.bound?(:_command_).must_equal(true) }
    end

  end # Bindings

end # Vedeu
