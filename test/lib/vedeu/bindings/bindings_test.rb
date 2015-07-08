require 'test_helper'

module Vedeu

  describe Bindings do

    context 'the system events needed by Vedeu to run are defined' do
      it { Vedeu.events.registered?(:_clear_).must_equal(true) }
      it { Vedeu.events.registered?(:_clear_group_).must_equal(true) }
      it { Vedeu.events.registered?(:_cleanup_).must_equal(true) }
      it { Vedeu.events.registered?(:_command_).must_equal(true) }
      it { Vedeu.events.registered?(:_exit_).must_equal(true) }
      it { Vedeu.events.registered?(:_initialize_).must_equal(true) }
      it { Vedeu.events.registered?(:_keypress_).must_equal(true) }
      it { Vedeu.events.registered?(:_log_).must_equal(true) }
      it { Vedeu.events.registered?(:_mode_switch_).must_equal(true) }
      it { Vedeu.events.registered?(:_refresh_).must_equal(true) }
      it { Vedeu.events.registered?(:_refresh_cursor_).must_equal(true) }
      it { Vedeu.events.registered?(:_refresh_group_).must_equal(true) }
      it { Vedeu.events.registered?(:_resize_).must_equal(true) }
    end

    context 'the geometry specific events are defined' do
      it { Vedeu.events.registered?(:_maximise_).must_equal(true) }
      it { Vedeu.events.registered?(:_unmaximise_).must_equal(true) }
    end

    context 'the focus specific events are defined' do
      it { Vedeu.events.registered?(:_focus_by_name_).must_equal(true) }
      it { Vedeu.events.registered?(:_focus_next_).must_equal(true) }
      it { Vedeu.events.registered?(:_focus_prev_).must_equal(true) }
    end

    context 'the refresh event for all registered interfaces is defined' do
      it { Vedeu.events.registered?(:_refresh_).must_equal(true) }
    end

  end # Bindings

end # Vedeu
