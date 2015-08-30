require 'test_helper'

module Vedeu

  module Bindings

    describe Focus do

      context 'the system events needed by Vedeu to run are defined' do
        it { Vedeu.bound?(:_focus_by_name_).must_equal(true) }
        it { Vedeu.bound?(:_focus_next_).must_equal(true) }
        it { Vedeu.bound?(:_focus_prev_).must_equal(true) }
      end

    end # Focus

  end # Bindings

end # Vedeu
