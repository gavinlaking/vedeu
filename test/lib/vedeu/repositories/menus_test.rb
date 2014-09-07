require 'test_helper'

module Vedeu

  describe Menus do

    describe 'System events defined by Menus' do
      before do
        Menus.reset
        Menus.add({ name:  'elements',
                    items: Vedeu::Menu.new([:sulphur, :gold, :tin, :helium]) })
      end

      it 'raises an exception when triggered with an unregistered name' do
        proc {
          Vedeu.trigger(:_menu_current_, 'unknown')
        }.must_raise(MenuNotFound)
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
        Vedeu.trigger(:_menu_select_, 'elements').must_equal(
          [
            [true, true, :sulphur],
            [false, false, :gold],
            [false, false, :tin],
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
        Vedeu.trigger(:_menu_items_, 'elements').must_equal(
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
      before { Menus.reset }

      it 'returns false if the menu name is empty' do
        Menus.add({ name: '' }).must_equal(false)
      end

      it 'adds the menu to the storage' do
        collection = [:hydrogen, :helium, :beryllium, :lithium]
        items      = Vedeu::Menu.new(collection)

        Menus.add({ name: 'elements', items: items })
        Menus.all.must_equal(
          {
            'elements' => { name: 'elements', items: items }
          }
        )
      end
    end

    describe '#all' do
      before do
        Menus.reset
        Menus.add({ name: 'barium' })
        Menus.add({ name: 'lanthanum' })
        Menus.add({ name: 'cerium' })
      end

      it 'returns the storage' do
        Menus.all.must_equal(
          {
            'barium' => { name: 'barium' },
            'lanthanum' => { name: 'lanthanum' },
            'cerium' => { name: 'cerium' }
          }
        )
      end
    end

    describe '#find' do
      before { Menus.add({ name: 'erbium' }) }

      it 'raises an exception if the menu cannot be found' do
        proc { Menus.find('not_found') }.must_raise(MenuNotFound)
      end

      it 'returns the attributes of the named menu' do
        Menus.find('erbium').must_equal({ name: 'erbium' })
      end
    end

    describe '#registered' do
      before do
        Menus.reset
        Menus.add({ name: 'barium' })
        Menus.add({ name: 'caesium' })
      end

      it 'returns all the registered menus from storage' do
        Menus.registered.must_equal(['barium', 'caesium'])
      end
    end

    describe '#registered?' do
      it 'returns true when the menu is registered' do
        Menus.add({ name: 'registered' })

        Menus.registered?('registered').must_equal(true)
      end

      it 'returns false when the menu is not registered' do
        Menus.registered?('not_registered').must_equal(false)
      end
    end

    describe '#remove' do
      it 'returns false when the menu is not registered' do
        Menus.remove('not_registered').must_equal(false)
      end

      it 'removes the menu from the repository' do
        Menus.add({ name: 'antimony' })
        Menus.registered?('antimony').must_equal(true)
        Menus.remove('antimony')
        Menus.registered?('antimony').must_equal(false)
      end

      it 'returns true when the menu was registered and is now removed' do
        Menus.add({ name: 'tellurium' })
        Menus.remove('tellurium').must_equal(true)
        Menus.registered?('tellurium').must_equal(false)
      end
    end

    describe '#reset' do
      before { Menus.reset }

      it 'removes all known menus from the storage' do
        Menus.add({ name: 'uranium' })
        Menus.all.must_equal({ 'uranium' => { name: 'uranium' } })
        Menus.reset.must_be_empty
      end
    end

    describe '#use' do
      it 'returns the Vedeu::Menu instance stored when the named menu exists' do
        collection = [:calcium, :fermium, :nitrogen, :palladium]
        items      = Vedeu::Menu.new(collection)
        Menus.add({ name: 'elements', items: items })

        Menus.use('elements').must_equal(items)
      end

      it 'raises an exception if there are no items' do
        Menus.add({ name: 'elements' })

        proc { Menus.use('elements') }.must_raise(MenuNotFound)
      end
    end

  end
end
