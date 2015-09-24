require 'test_helper'

module Vedeu

  module Bindings

    describe View do

      context 'the system events needed by Vedeu to run are defined' do
        it { Vedeu.bound?(:_maximise_).must_equal(true) }
        it { Vedeu.bound?(:_resize_).must_equal(true) }
        it { Vedeu.bound?(:_unmaximise_).must_equal(true) }
      end

    end # View

  end # Bindings

end # Vedeu
