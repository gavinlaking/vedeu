require 'test_helper'

module Vedeu

  module Bindings

    describe DRB do

      context 'the drb specific events are defined' do
        it { Vedeu.bound?(:_drb_input_).must_equal(true) }
        it { Vedeu.bound?(:_drb_retrieve_output_).must_equal(true) }
        it { Vedeu.bound?(:_drb_store_output_).must_equal(true) }
        it { Vedeu.bound?(:_drb_restart_).must_equal(true) }
        it { Vedeu.bound?(:_drb_start_).must_equal(true) }
        it { Vedeu.bound?(:_drb_status_).must_equal(true) }
        it { Vedeu.bound?(:_drb_stop_).must_equal(true) }
      end

    end # DRB

  end # Bindings

end # Vedeu
