require 'test_helper'

module Vedeu

  module Bindings

    describe System do

      context 'the system events needed by Vedeu to run are defined' do
        it { Vedeu.bound?(:_clear_).must_equal(true) }
        it { Vedeu.bound?(:_clear_group_).must_equal(true) }
        it { Vedeu.bound?(:_cleanup_).must_equal(true) }
        it { Vedeu.bound?(:_command_).must_equal(true) }
        it { Vedeu.bound?(:_exit_).must_equal(true) }
        it { Vedeu.bound?(:_initialize_).must_equal(true) }
        it { Vedeu.bound?(:_keypress_).must_equal(true) }
        it { Vedeu.bound?(:_log_).must_equal(true) }
        it { Vedeu.bound?(:_mode_switch_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_cursor_).must_equal(true) }
        it { Vedeu.bound?(:_refresh_group_).must_equal(true) }
        it { Vedeu.bound?(:_resize_).must_equal(true) }
      end

      context 'the geometry specific events are defined' do
        it { Vedeu.bound?(:_maximise_).must_equal(true) }
        it { Vedeu.bound?(:_unmaximise_).must_equal(true) }
      end

      context 'the focus specific events are defined' do
        it { Vedeu.bound?(:_focus_by_name_).must_equal(true) }
        it { Vedeu.bound?(:_focus_next_).must_equal(true) }
        it { Vedeu.bound?(:_focus_prev_).must_equal(true) }
      end

      context 'the refresh event for all registered interfaces is defined' do
        it { Vedeu.bound?(:_refresh_).must_equal(true) }
      end

    end # System

  end # Bindings

end # Vedeu
