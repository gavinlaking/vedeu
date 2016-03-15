# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_menu_bottom_).must_equal(true) }
    it { Vedeu.bound?(:_menu_current_).must_equal(true) }
    it { Vedeu.bound?(:_menu_deselect_).must_equal(true) }
    it { Vedeu.bound?(:_menu_items_).must_equal(true) }
    it { Vedeu.bound?(:_menu_next_).must_equal(true) }
    it { Vedeu.bound?(:_menu_prev_).must_equal(true) }
    it { Vedeu.bound?(:_menu_selected_).must_equal(true) }
    it { Vedeu.bound?(:_menu_select_).must_equal(true) }
    it { Vedeu.bound?(:_menu_top_).must_equal(true) }
    it { Vedeu.bound?(:_menu_view_).must_equal(true) }
  end

  module Menus

    describe Repository do

      let(:described) { Vedeu::Menus::Repository }

    end # Repository

  end # Menus

end # Vedeu
