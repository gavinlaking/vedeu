require 'test_helper'
require 'vedeu/support/menu'

module Vedeu
  describe Menu do
    let(:collection) { ['hydrogen', 'carbon', 'nitrogen', 'oxygen'] }
    let(:menu)       { Menu.new(collection) }

    describe '#events' do
      it 'returns the events defined for menus' do
        menu.events.must_be_instance_of(Array)
      end
    end

    describe '#current' do
      it 'returns the current index' do
        menu.current.must_equal(0)
      end
    end

    describe '#selected' do
      it 'returns nil when no item is selected' do
        menu.selected.must_equal(nil)
      end

      it 'returns the selected index when an item is selected' do
        menu.next_item
        menu.select_item
        menu.selected.must_equal(1)
      end
    end

    describe '#current_item' do
      it 'returns the current item from the collection' do
        menu.current_item.must_equal('hydrogen')
      end

      it 'when the current item has changed' do
        menu.next_item
        menu.next_item
        menu.current_item.must_equal('nitrogen')
      end
    end

    describe '#selected_item' do
      it 'returns nil when nothing is selected' do
        menu.selected_item.must_equal(nil)
      end

      it 'returns the selected item from the collection' do
        menu.next_item
        menu.select_item
        menu.selected_item.must_equal('carbon')
      end
    end

    describe '#items' do
      it 'returns a tuple' do
        menu.items.must_equal(
          [
            [false, true,  'hydrogen'],
            [false, false, 'carbon'],
            [false, false, 'nitrogen'],
            [false, false, 'oxygen']
          ]
        )
      end

      it 'returns a tuple when the current has changed' do
        menu.next_item
        menu.items.must_equal(
          [
            [false, false, 'hydrogen'],
            [false, true,  'carbon'],
            [false, false, 'nitrogen'],
            [false, false, 'oxygen']
          ]
        )
      end

      it 'returns a tuple when an item is selected' do
        menu.next_item
        menu.select_item
        menu.items.must_equal(
          [
            [false, false, 'hydrogen'],
            [true,  true,  'carbon'],
            [false, false, 'nitrogen'],
            [false, false, 'oxygen']
          ]
        )
      end

      it 'returns a tuple when the current has changed and an item ' \
         'is selected' do
        menu.next_item
        menu.select_item
        menu.next_item
        menu.next_item
        menu.items.must_equal(
          [
            [false, false, 'hydrogen'],
            [true,  false, 'carbon'],
            [false, false, 'nitrogen'],
            [false, true,  'oxygen']
          ]
        )
      end
    end

    describe '#render' do
      it 'returns a tuple' do
        menu.render.must_equal(
          [
            ' > hydrogen',
            '   carbon',
            '   nitrogen',
            '   oxygen'
          ]
        )
      end

      it 'returns a tuple when the current has changed' do
        menu.next_item
        menu.render.must_equal(
          [
            '   hydrogen',
            ' > carbon',
            '   nitrogen',
            '   oxygen'
          ]
        )
      end

      it 'returns a tuple when an item is selected' do
        menu.next_item
        menu.select_item
        menu.render.must_equal(
          [
            '   hydrogen',
            '*> carbon',
            '   nitrogen',
            '   oxygen'
          ]
        )
      end

      it 'returns a tuple when the current has changed and an item ' \
         'is selected' do
        menu.next_item
        menu.select_item
        menu.next_item
        menu.next_item
        menu.render.must_equal(
          [
            '   hydrogen',
            '*  carbon',
            '   nitrogen',
            ' > oxygen'
          ]
        )
      end
    end

    describe '#top_item' do
      it 'sets current to the index of the first item' do
        menu.next_item
        menu.top_item
        menu.current.must_equal(0)
      end

      it 'returns the items' do
        menu.top_item.must_equal(menu.items)
      end
    end

    describe '#bottom_item' do
      it 'sets current to the index of the last item' do
        menu.bottom_item
        menu.current.must_equal(3)
      end

      it 'returns the items' do
        menu.bottom_item.must_equal(menu.items)
      end
    end

    describe '#next_item' do
      it 'sets the current to the index of the next item' do
        menu.next_item
        menu.current.must_equal(1)
      end

      it 'returns the items' do
        menu.next_item.must_equal(menu.items)
      end

      it 'does not loop' do
        menu.next_item
        menu.next_item
        menu.next_item
        menu.next_item
        menu.next_item
        menu.current.must_equal(3)
      end
    end

    describe '#prev_item' do
      it 'does not loop' do
        menu.prev_item
        menu.current.must_equal(0)
      end

      it 'sets the current to the index of the previous item' do
        menu.next_item
        menu.next_item
        menu.prev_item
        menu.current.must_equal(1)
      end

      it 'returns the items' do
        menu.prev_item.must_equal(menu.items)
      end

      it 'does not loop' do
        menu.next_item
        menu.next_item
        menu.next_item
        menu.prev_item
        menu.prev_item
        menu.current.must_equal(1)
      end
    end

    describe '#select_item' do
      it 'sets the selected index to the current index' do
        menu.select_item
        menu.selected.must_equal(0)
      end

      it 'sets the selected index to the current index' do
        menu.next_item
        menu.select_item
        menu.selected.must_equal(1)
      end

      it 'returns the items' do
        menu.select_item.must_equal(menu.items)
      end
    end

    describe '#deselect_item' do
      it 'sets the selected index to nil' do
        menu.next_item
        menu.next_item
        menu.select_item
        menu.deselect_item
        menu.selected.must_equal(nil)
      end

      it 'returns the items' do
        menu.deselect_item.must_equal(menu.items)
      end
    end

    describe '#last' do
      it 'returns the index of the last item' do
        menu.last.must_equal(3)
      end
    end

    describe '#size' do
      it 'returns the collection size' do
        menu.size.must_equal(4)
      end
    end
  end
end
