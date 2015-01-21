require 'test_helper'

module Vedeu

  describe Menu do

    let(:described)  { Menu.new(collection, menu_name, current, selected) }
    let(:collection) { ['hydrogen', 'carbon', 'nitrogen', 'oxygen'] }
    let(:menu_name)  { 'elements' }
    let(:current)    { 0 }
    let(:selected)   {}

    describe '.build' do
      it { skip }
    end

    describe '.menu' do
      it { skip }
    end

    describe '#initialize' do
      it { return_type_for(described, Menu) }
      it { assigns(described, '@collection', collection) }
      it { assigns(described, '@name', 'elements') }
      it { assigns(described, '@current', 0) }
      it { assigns(described, '@selected', nil) }
      it { assigns(described, '@repository', Vedeu.menus) }
    end

    describe '#current' do
      it 'returns the current index' do
        described.current.must_equal(0)
      end
    end

    describe '#selected' do
      it 'returns nil when no item is selected' do
        described.selected.must_equal(nil)
      end

      it 'returns the selected index when an item is selected' do
        described.next_item
        described.select_item
        described.selected.must_equal(1)
      end
    end

    describe '#current_item' do
      it 'returns the current item from the collection' do
        described.current_item.must_equal('hydrogen')
      end

      it 'when the current item has changed' do
        described.next_item
        described.next_item
        described.current_item.must_equal('nitrogen')
      end
    end

    describe '#selected_item' do
      it 'returns nil when nothing is selected' do
        described.selected_item.must_equal(nil)
      end

      it 'returns the selected item from the collection' do
        described.next_item
        described.select_item
        described.selected_item.must_equal('carbon')
      end
    end

    describe '#items' do
      it 'returns a collection of items' do
        described.items.must_equal(
          [
            [false, true,  'hydrogen'],
            [false, false, 'carbon'],
            [false, false, 'nitrogen'],
            [false, false, 'oxygen']
          ]
        )
      end

      it 'returns a collection of items when the current has ' \
         'changed' do
        described.next_item
        described.items.must_equal(
          [
            [false, false, 'hydrogen'],
            [false, true,  'carbon'],
            [false, false, 'nitrogen'],
            [false, false, 'oxygen']
          ]
        )
      end

      it 'returns a collection of items when an item is selected' do
        described.next_item
        described.select_item
        described.items.must_equal(
          [
            [false, false, 'hydrogen'],
            [true,  true,  'carbon'],
            [false, false, 'nitrogen'],
            [false, false, 'oxygen']
          ]
        )
      end

      it 'returns a collection of items when the current has ' \
         'changed and an item is selected' do
        described.next_item
        described.select_item
        described.next_item
        described.next_item
        described.items.must_equal(
          [
            [false, false, 'hydrogen'],
            [true,  false, 'carbon'],
            [false, false, 'nitrogen'],
            [false, true,  'oxygen']
          ]
        )
      end
    end

    describe '#view' do
      it 'returns a collection of items when the start position ' \
         'has changed' do
        described.top_item
        described.next_item
        described.view.must_equal(
          [
            [false, true, 'carbon'],
            [false, false, 'nitrogen'],
            [false, false, 'oxygen']
          ]
        )
      end
    end

    describe '#top_item' do
      it 'sets current to the index of the first item' do
        described.next_item
        described.top_item
        described.current.must_equal(0)
      end

      it 'returns the items' do
        described.top_item.must_equal(described.items)
      end
    end

    describe '#bottom_item' do
      it 'sets current to the index of the last item' do
        described.bottom_item
        described.current.must_equal(3)
      end

      it 'returns the items' do
        described.bottom_item.must_equal(described.items)
      end
    end

    describe '#next_item' do
      it 'sets the current to the index of the next item' do
        described.next_item
        described.current.must_equal(1)
      end

      it 'returns the items' do
        described.next_item.must_equal(described.items)
      end

      it 'does not loop' do
        described.next_item
        described.next_item
        described.next_item
        described.next_item
        described.next_item
        described.current.must_equal(3)
      end
    end

    describe '#prev_item' do
      it 'does not loop' do
        described.prev_item
        described.current.must_equal(0)
      end

      it 'sets the current to the index of the previous item' do
        described.next_item
        described.next_item
        described.prev_item
        described.current.must_equal(1)
      end

      it 'returns the items' do
        described.prev_item.must_equal(described.items)
      end

      it 'does not loop' do
        described.next_item
        described.next_item
        described.next_item
        described.prev_item
        described.prev_item
        described.current.must_equal(1)
      end
    end

    describe '#select_item' do
      it 'sets the selected index to the current index' do
        described.select_item
        described.selected.must_equal(0)
      end

      it 'sets the selected index to the current index' do
        described.next_item
        described.select_item
        described.selected.must_equal(1)
      end

      it 'returns the items' do
        described.select_item.must_equal(described.items)
      end
    end

    describe '#deselect_item' do
      it 'sets the selected index to nil' do
        described.next_item
        described.next_item
        described.select_item
        described.deselect_item
        described.selected.must_equal(nil)
      end

      it 'returns the items' do
        described.deselect_item.must_equal(described.items)
      end
    end

    describe '#last' do
      it 'returns the index of the last item' do
        described.last.must_equal(3)
      end
    end

    describe '#size' do
      it 'returns the collection size' do
        described.size.must_equal(4)
      end
    end

  end # Menu

end # Vedeu
