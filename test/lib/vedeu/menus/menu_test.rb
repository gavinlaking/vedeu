# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Menus

    describe Menu do

      let(:described)  { Vedeu::Menus::Menu }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          collection: collection,
          name:       menu_name,
          current:    current,
          selected:   selected,
        }
      }
      let(:collection) { ['hydrogen', 'carbon', 'nitrogen', 'oxygen'] }
      let(:menu_name)  { 'elements' }
      let(:current)    { 0 }
      let(:selected)   {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it do
          instance.instance_variable_get('@collection').must_equal(collection)
        end
        it { instance.instance_variable_get('@name').must_equal('elements') }
        it { instance.instance_variable_get('@current').must_equal(0) }
        it { assert_nil(instance.instance_variable_get('@selected')) }
        it do
          instance.instance_variable_get('@repository').must_equal(Vedeu.menus)
        end
      end

      describe '#collection' do
        it { instance.must_respond_to(:collection) }
      end

      describe '#collection=' do
        it { instance.must_respond_to(:collection=) }
      end

      describe '#current=' do
        it { instance.must_respond_to(:current=) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#name=' do
        it { instance.must_respond_to(:name=) }
      end

      describe '#current' do
        subject { instance.current }

        it 'returns the current index' do
          subject.must_equal(0)
        end
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::Menus::DSL)
        end
      end

      describe '#selected' do
        subject { instance.selected }

        it 'returns nil when no item is selected' do
          assert_nil(subject)
        end

        it 'returns the selected index when an item is selected' do
          instance.next_item
          instance.select_item

          subject.must_equal(1)
        end
      end

      describe '#selected=' do
        it { instance.must_respond_to(:selected=) }
      end

      describe '#current_item' do
        subject { instance.current_item }

        it 'returns the current item from the collection' do
          subject.must_equal('hydrogen')
        end

        it 'when the current item has changed' do
          instance.next_item
          instance.next_item

          subject.must_equal('nitrogen')
        end
      end

      describe '#selected_item' do
        subject { instance.selected_item }

        it 'returns nil when nothing is selected' do
          assert_nil(subject)
        end

        it 'returns the selected item from the collection' do
          instance.next_item
          instance.select_item

          subject.must_equal('carbon')
        end
      end

      describe '#items' do
        it 'returns a collection of items' do
          instance.items.must_equal(
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
          instance.next_item
          instance.items.must_equal(
            [
              [false, false, 'hydrogen'],
              [false, true,  'carbon'],
              [false, false, 'nitrogen'],
              [false, false, 'oxygen']
            ]
          )
        end

        it 'returns a collection of items when an item is selected' do
          instance.next_item
          instance.select_item
          instance.items.must_equal(
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
          instance.next_item
          instance.select_item
          instance.next_item
          instance.next_item
          instance.items.must_equal(
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
          instance.top_item
          instance.next_item
          instance.view.must_equal(
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
          instance.next_item
          instance.top_item
          instance.current.must_equal(0)
        end

        it 'returns the items' do
          instance.top_item.must_equal(instance.items)
        end
      end

      describe '#bottom_item' do
        it 'sets current to the index of the last item' do
          instance.bottom_item
          instance.current.must_equal(3)
        end

        it 'returns the items' do
          instance.bottom_item.must_equal(instance.items)
        end
      end

      describe '#next_item' do
        it 'sets the current to the index of the next item' do
          instance.next_item
          instance.current.must_equal(1)
        end

        it 'returns the items' do
          instance.next_item.must_equal(instance.items)
        end

        it 'does not loop' do
          instance.next_item
          instance.next_item
          instance.next_item
          instance.next_item
          instance.next_item
          instance.current.must_equal(3)
        end
      end

      describe '#prev_item' do
        it 'does not loop' do
          instance.prev_item
          instance.current.must_equal(0)
        end

        it 'sets the current to the index of the previous item' do
          instance.next_item
          instance.next_item
          instance.prev_item
          instance.current.must_equal(1)
        end

        it 'returns the items' do
          instance.prev_item.must_equal(instance.items)
        end

        it 'does not loop' do
          instance.next_item
          instance.next_item
          instance.next_item
          instance.prev_item
          instance.prev_item
          instance.current.must_equal(1)
        end
      end

      describe '#select_item' do
        it 'sets the selected index to the current index' do
          instance.select_item
          instance.selected.must_equal(0)
        end

        it 'sets the selected index to the current index' do
          instance.next_item
          instance.select_item
          instance.selected.must_equal(1)
        end

        it 'returns the items' do
          instance.select_item.must_equal(instance.items)
        end
      end

      describe '#deselect_item' do
        it 'sets the selected index to nil' do
          instance.next_item
          instance.next_item
          instance.select_item
          instance.deselect_item
          assert_nil(instance.selected)
        end

        it 'returns the items' do
          instance.deselect_item.must_equal(instance.items)
        end
      end

      describe '#last' do
        it 'returns the index of the last item' do
          instance.last.must_equal(3)
        end
      end

      describe '#size' do
        it 'returns the collection size' do
          instance.size.must_equal(4)
        end
      end

    end # Menu

  end # Menus

end # Vedeu
