require 'test_helper'

module Vedeu

  describe Menus do

    describe ' system events defined by Menus' do
      let(:collection) { [:sulphur, :gold, :tin, :helium] }
      let(:instance)   { Vedeu::Menu.new(collection) }

      before do
        Menus.reset
        Menus.add({ name:  'elements',
                    items: collection })
        Vedeu::Menu.stubs(:new).returns(instance)
      end

      it '_menu_current_' do
        Vedeu.trigger(:_menu_current_, 'elements').must_equal(:sulphur)
      end

      it '_menu_selected_ when no item is selected' do
        Vedeu.trigger(:_menu_selected_, 'elements').must_equal([nil])
      end

      it '_menu_selected_ when an item is selected' do
        Vedeu.trigger(:_menu_next_, 'elements')
        Vedeu.trigger(:_menu_select_, 'elements')
        Vedeu.trigger(:_menu_selected_, 'elements').must_equal(:gold)
      end

      it '_menu_next_' do
        Vedeu.trigger(:_menu_next_, 'elements').must_equal(
          [
            [false, false, :sulphur],
            [false, true, :gold],
            [false, false, :tin],
            [false, false, :helium]
          ]
        )
      end

      it '_menu_prev_' do
        Vedeu.trigger(:_menu_prev_, 'elements').must_equal(
          [
            [false, true, :sulphur],
            [false, false, :gold],
            [false, false, :tin],
            [false, false, :helium]
          ]
        )
      end

      it '_menu_top_' do
        Vedeu.trigger(:_menu_top_, 'elements').must_equal(
          [
            [false, true, :sulphur],
            [false, false, :gold],
            [false, false, :tin],
            [false, false, :helium]
          ]
        )
      end

      it '_menu_bottom_' do
        Vedeu.trigger(:_menu_bottom_, 'elements').must_equal(
          [
            [false, false, :sulphur],
            [false, false, :gold],
            [false, false, :tin],
            [false, true, :helium]
          ]
        )
      end

      it '_menu_select_' do
        2.times { Vedeu.trigger(:_menu_next_, 'elements') }

        Vedeu.trigger(:_menu_select_, 'elements').must_equal(
          [
            [false, false, :sulphur],
            [false, false, :gold],
            [true,  true,  :tin],
            [false, false, :helium]
          ]
        )
      end

      it '_menu_deselect_' do
        Vedeu.trigger(:_menu_deselect_, 'elements').must_equal(
          [
            [false, true, :sulphur],
            [false, false, :gold],
            [false, false, :tin],
            [false, false, :helium]
          ]
        )
      end

      it '_menu_items_' do
        2.times { Vedeu.trigger(:_menu_next_, 'elements') }
        Vedeu.trigger(:_menu_select_, 'elements')
        Vedeu.trigger(:_menu_prev_, 'elements')

        Vedeu.trigger(:_menu_items_, 'elements').must_equal(
          [
            [false, false, :sulphur],
            [false, true,  :gold],
            [true,  false, :tin],
            [false, false, :helium]
          ]
        )
      end

      it '_menu_view_' do
        Vedeu.trigger(:_menu_view_, 'elements').must_equal(
          [
            [false, true, :sulphur],
            [false, false, :gold],
            [false, false, :tin],
            [false, false, :helium]
          ]
        )
      end
    end

    describe '#add' do
      let(:collection) { [:hydrogen, :helium, :beryllium, :lithium] }
      let(:instance)   { Vedeu::Menu.new(collection) }

      before do
        Menus.reset
        Vedeu::Menu.stubs(:new).returns(instance)
      end

      context 'when the menu name is empty' do
        it { proc { Menus.add({ name: '' }) }.must_raise(MissingRequired) }
      end

      it 'adds the menu to the storage' do
        Menus.add({ name: 'elements', items: collection })
        Menus.all.must_equal(
          {
            'elements' => { name: 'elements', items: instance }
          }
        )
      end
    end

    describe '#use' do
      let(:collection) { [:calcium, :fermium, :nitrogen, :palladium] }
      let(:instance)   { Vedeu::Menu.new(collection) }

      before do
        Menus.reset
        Vedeu::Menu.stubs(:new).returns(instance)
      end

      it 'returns the Vedeu::Menu instance stored when the named menu exists' do
        Menus.add({ name: 'elements', items: collection })

        Menus.use('elements').must_equal(instance)
      end
    end

  end # Menus

end # Vedeu
