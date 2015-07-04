require 'test_helper'

module Vedeu

  module Bindings

    describe Visibility do

      context 'the visibility events are defined' do
        it { Vedeu.events.registered?(:_cursor_hide_).must_equal(true) }
        it { Vedeu.events.registered?(:_cursor_show_).must_equal(true) }
        it { Vedeu.events.registered?(:_hide_cursor_).must_equal(true) }
        it { Vedeu.events.registered?(:_show_cursor_).must_equal(true) }

        it { Vedeu.events.registered?(:_hide_group_).must_equal(true) }
        it { Vedeu.events.registered?(:_show_group_).must_equal(true) }

        it { Vedeu.events.registered?(:_hide_interface_).must_equal(true) }
        it { Vedeu.events.registered?(:_show_interface_).must_equal(true) }
        it { Vedeu.events.registered?(:_toggle_interface_).must_equal(true) }
      end

    end # Visibility

  end # Bindings

end # Vedeu
