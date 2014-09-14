require 'test_helper'

module Vedeu
  describe Cursor do
    let(:attributes) {
      {
          name:     'mercury',
          geometry: {
            width:  10,
            height: 4,
            x:      12,
            y:      5
          },
          cursor: true
      }
    }
    let(:interface)  { Interface.new(attributes) }

    describe '#initialize' do
      it 'returns an instance of itself' do
        Cursor.new(interface).must_be_instance_of(Cursor)
      end
    end

    describe '#attributes' do
      it 'returns a hash containing the state of the instance' do
        Cursor.new(interface).attributes.must_equal(
          { visible: false, x: 12, y: 5 }
        )
      end
    end

    describe '#cursor_y' do
      it 'returns the y coordinate of the cursor' do
        Cursor.new(interface).cursor_y.must_equal(5)
      end
    end

    describe '#cursor_x' do
      it 'returns the x coordinate of the cursor' do
        Cursor.new(interface).cursor_x.must_equal(12)
      end
    end

    describe '#position' do
      it 'returns the current cursor position' do
        cursor = Cursor.new(interface)
        cursor.position.must_equal([5, 12])
      end
    end

    describe '#visible' do
      it 'returns a boolean indicating visibility' do
        Cursor.new(interface).visible.must_equal(false)
      end
    end

    describe '#move_up' do
      it 'does not move up when already at the top' do
        cursor = Cursor.new(interface)
        cursor.move_up
        cursor.position.must_equal([5, 12])
      end

      it 'moves the cursor up' do
        cursor = Cursor.new(interface)
        3.times { cursor.move_down }
        cursor.move_up
        cursor.position.must_equal([7, 12])
      end
    end

    describe '#move_down' do
      it 'moves the cursor down' do
        cursor = Cursor.new(interface)
        cursor.move_down
        cursor.position.must_equal([6, 12])
      end

      it 'does not move down when already at the bottom' do
        cursor = Cursor.new(interface)
        5.times { cursor.move_down }
        cursor.position.must_equal([9, 12])
      end
    end

    describe '#move_left' do
      it 'does not move left when already at leftmost' do
        cursor = Cursor.new(interface)
        cursor.move_left
        cursor.position.must_equal([5, 12])
      end

      it 'moves the cursor left' do
        cursor = Cursor.new(interface)
        3.times { cursor.move_right }
        cursor.move_left
        cursor.position.must_equal([5, 14])
      end
    end

    describe '#move_right' do
      it 'does not move right when already at rightmost' do
        cursor = Cursor.new(interface)
        11.times { cursor.move_right }
        cursor.position.must_equal([5, 22])
      end

      it 'moves the cursor right' do
        cursor = Cursor.new(interface)
        cursor.move_right
        cursor.position.must_equal([5, 13])
      end
    end

    describe '#show_cursor' do
      it 'sets the visible attribute to true' do
        cursor = Cursor.new(interface)
        cursor.show_cursor
        cursor.visible.must_equal(true)
      end
    end

    describe '#hide_cursor' do
      it 'sets the visible attribute to false' do
        cursor = Cursor.new(interface)
        cursor.hide_cursor
        cursor.visible.must_equal(false)
      end
    end

    describe '#to_s' do
      it 'returns the escape sequence to position and set the visibility of ' \
         'the cursor' do
        Cursor.new(interface).to_s.must_equal("\e[5;12H\e[?25l")
      end

      it 'returns the escape sequence to position and set the visibility of ' \
         'the cursor and returns to that position after yielding the block' do
        Cursor.new(interface).to_s do
          # ...
        end.must_equal("\e[5;12H\e[?25l\e[5;12H\e[?25l")
      end
    end
  end
end
