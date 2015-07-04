require 'test_helper'

module Vedeu

  module Bindings

    describe Menus do

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

    end # Menus

  end # Bindings

end # Vedeu
