require 'test_helper'

module Vedeu

  module Bindings

    describe Refresh do

      context 'the system events needed by Vedeu to run are defined' do
        it { Vedeu.bound?(:_refresh_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_border_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_cursor_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_group_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_view_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_view_content_).must_equal(true) }
      end

    end # Refresh

  end # Bindings

end # Vedeu
