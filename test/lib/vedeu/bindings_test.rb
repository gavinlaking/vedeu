require 'test_helper'

module Vedeu

  describe Bindings do

    context 'the system events needed by Vedeu to run are defined' do
      it { Vedeu.events.registered?(:_clear_).must_equal(true) }
      it { Vedeu.events.registered?(:_exit_).must_equal(true) }
      it { Vedeu.events.registered?(:_initialize_).must_equal(true) }
      it { Vedeu.events.registered?(:_keypress_).must_equal(true) }
      it { Vedeu.events.registered?(:_log_).must_equal(true) }
      it { Vedeu.events.registered?(:_mode_switch_).must_equal(true) }
      it { Vedeu.events.registered?(:_resize_).must_equal(true) }
    end

    context 'the cursor specific events are defined' do
      it { Vedeu.events.registered?(:_cursor_hide_).must_equal(true) }
      it { Vedeu.events.registered?(:_cursor_show_).must_equal(true) }
      it { Vedeu.events.registered?(:_cursor_down_).must_equal(true) }
      it { Vedeu.events.registered?(:_cursor_left_).must_equal(true) }
      it { Vedeu.events.registered?(:_cursor_right_).must_equal(true) }
      it { Vedeu.events.registered?(:_cursor_up_).must_equal(true) }
      it { Vedeu.events.registered?(:_cursor_origin_).must_equal(true) }
    end

    context 'the focus specific events are defined' do
      it { Vedeu.events.registered?(:_focus_by_name_).must_equal(true) }
      it { Vedeu.events.registered?(:_focus_next_).must_equal(true) }
      it { Vedeu.events.registered?(:_focus_prev_).must_equal(true) }
    end

    context 'the menu specific events are defined' do
      it { Vedeu.events.registered?(:_menu_bottom_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_current_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_deselect_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_items_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_next_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_prev_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_selected_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_select_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_top_).must_equal(true) }
      it { Vedeu.events.registered?(:_menu_view_).must_equal(true) }
    end

    context 'the refresh event for all registered interfaces is defined' do
      it { Vedeu.events.registered?(:_refresh_).must_equal(true) }
    end

  end # Bindings

end # Vedeu
