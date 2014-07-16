require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/menu'

module Vedeu
  describe Menu do
    let(:collection) { ['hydrogen', 'carbon', 'nitrogen', 'oxygen'] }
    let(:menu)       { Menu.new(collection) }

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
        menu.next.select
        menu.selected.must_equal(1)
      end
    end

    describe '#current_item' do
      it 'returns a tuple containing the current index and item' do
        menu.current_item.must_equal([0, 'hydrogen'])
      end

      it 'when the current item has changed, the tuple will change' do
        menu.next.next
        menu.current_item.must_equal([2, 'nitrogen'])
      end
    end

    describe '#selected_item' do
      it 'returns nil when nothing is selected' do
        menu.selected_item.must_equal(nil)
      end

      it 'returns a tuple containing the selected index and item' do
        menu.next.select
        menu.selected_item.must_equal([1, 'carbon'])
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
        menu.next.items.must_equal(
          [
            [false, false, "hydrogen"],
            [false, true,  "carbon"],
            [false, false, "nitrogen"],
            [false, false, "oxygen"]
          ]
        )
      end

      it 'returns a tuple when an item is selected' do
        menu.next.select
        menu.items.must_equal(
          [
            [false, false, "hydrogen"],
            [true,  true,  "carbon"],
            [false, false, "nitrogen"],
            [false, false, "oxygen"]
          ]
        )
      end

      it 'returns a tuple when the current has changed and an item ' \
         'is selected' do
        menu.next.select
        menu.next.next
        menu.items.must_equal(
          [
            [false, false, "hydrogen"],
            [true,  false, "carbon"],
            [false, false, "nitrogen"],
            [false, true,  "oxygen"]
          ]
        )
      end
    end

    describe '#render' do
      it 'returns a tuple' do
        menu.render.must_equal(
          [" > hydrogen", "   carbon", "   nitrogen", "   oxygen"]
        )
      end

      it 'returns a tuple when the current has changed' do
        menu.next.render.must_equal(
          ["   hydrogen", " > carbon", "   nitrogen", "   oxygen"]
        )
      end

      it 'returns a tuple when an item is selected' do
        menu.next.select
        menu.render.must_equal(
          ["   hydrogen", "*> carbon", "   nitrogen", "   oxygen"]
        )
      end

      it 'returns a tuple when the current has changed and an item ' \
         'is selected' do
        menu.next.select
        menu.next.next
        menu.render.must_equal(
          ["   hydrogen", "*  carbon", "   nitrogen", " > oxygen"]
        )
      end
    end

    describe '#top' do
      it 'sets current to the index of the first item' do
        menu.next
        menu.top.must_equal(0)
      end
    end

    describe '#bottom' do
      it 'sets current to the index of the last item' do
        menu.bottom.must_equal(3)
      end
    end

    describe '#next' do
      it 'sets the current to the index of the next item' do
        menu.next.current.must_equal(1)
      end

      it 'returns the instance' do
        menu.next.must_equal(menu)
      end

      it 'is chainable but does not loop' do
        menu.next.next.next.next.next.current.must_equal(3)
      end
    end

    describe '#prev' do
      it 'does not loop' do
        menu.prev.current.must_equal(0)
      end

      it 'sets the current to the index of the previous item' do
        menu.next.next.prev.current.must_equal(1)
      end

      it 'returns the instance' do
        menu.prev.must_equal(menu)
      end

      it 'is chainable' do
        menu.next.next.next.prev.prev.current.must_equal(1)
      end
    end

    describe '#select' do
      it 'sets the selected index to the current index' do
        menu.select.must_equal(0)
      end

      it 'sets the selected index to the current index' do
        menu.next.select.must_equal(1)
      end
    end

    describe '#deselect' do
      it 'sets the selected index to nil' do
        menu.next.next.select
        menu.deselect.must_equal(nil)
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
