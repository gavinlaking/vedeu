require 'test_helper'

module Vedeu
  describe Cursor do
    let(:attributes) {
      {
        name:  'silver',
        state: :show,
        x:     12,
        y:     5,
      }
    }

    before do
      Interfaces.reset
      Vedeu.interface 'silver' do
        width  10
        height 4
        x      12
        y      5
      end
    end

    describe '#initialize' do
      it 'returns an instance of itself' do
        Cursor.new(attributes).must_be_instance_of(Cursor)
      end
    end

    describe '#attributes' do
      it 'returns a hash containing the attributes of the instance' do
        Cursor.new(attributes).attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 5 }
        )
      end
    end

    describe '#move_up' do
      it 'does not move up when already at the top' do
        cursor = Cursor.new(attributes)
        cursor.move_up
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 5 }
        )
      end

      it 'moves the cursor up' do
        cursor = Cursor.new(attributes)
        3.times { cursor.move_down }
        cursor.move_up
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 7 }
        )
      end
    end

    describe '#move_down' do
      it 'moves the cursor down' do
        cursor = Cursor.new(attributes)
        cursor.move_down
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 6 }
        )
      end

      it 'does not move down when already at the bottom' do
        cursor = Cursor.new(attributes)
        5.times { cursor.move_down }
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 8 }
        )
      end
    end

    describe '#move_left' do
      it 'does not move left when already at leftmost' do
        cursor = Cursor.new(attributes)
        cursor.move_left
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 5 }
        )
      end

      it 'moves the cursor left' do
        cursor = Cursor.new(attributes)
        3.times { cursor.move_right }
        cursor.move_left
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 14, y: 5 }
        )
      end
    end

    describe '#move_right' do
      it 'does not move right when already at rightmost' do
        cursor = Cursor.new(attributes)
        11.times { cursor.move_right }
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 21, y: 5 }
        )
      end

      it 'moves the cursor right' do
        cursor = Cursor.new(attributes)
        cursor.move_right
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 13, y: 5 }
        )
      end
    end

    describe '#show' do
      it 'sets the state attribute to :show' do
        cursor = Cursor.new(attributes)
        cursor.hide
        cursor.attributes.must_equal(
          { name: 'silver', state: :hide, x: 12, y: 5 }
        )
        cursor.show
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 5 }
        )
      end
    end

    describe '#hide' do
      it 'sets the state attribute to :hide' do
        cursor = Cursor.new(attributes)
        cursor.hide
        cursor.attributes.must_equal(
          { name: 'silver', state: :hide, x: 12, y: 5 }
        )
      end
    end

    describe '#toggle' do
      it 'sets the visibility to the opposite of its current state' do
        cursor = Cursor.new(attributes)
        cursor.toggle
        cursor.attributes.must_equal(
          { name: 'silver', state: :hide, x: 12, y: 5 }
        )
        cursor.toggle
        cursor.attributes.must_equal(
          { name: 'silver', state: :show, x: 12, y: 5 }
        )
      end
    end

    describe '#to_s' do
      it 'returns the escape sequence to position and set the visibility of ' \
         'the cursor' do
        Cursor.new(attributes).to_s.must_equal("\e[5;12H\e[?25h")
      end

      it 'returns the escape sequence to position and set the visibility of ' \
         'the cursor and returns to that position after yielding the block' do
        Cursor.new(attributes).to_s do
          # ...
        end.must_equal("\e[5;12H\e[?25h\e[5;12H\e[?25h")
      end
    end
  end
end
