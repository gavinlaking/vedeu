require 'test_helper'

module Vedeu
  describe Cursor do
    let(:attributes) {
      {
        top:     3,
        bottom:  6,
        left:    3,
        right:   6,
        visible: false,
      }
    }

    describe '#position' do
      it 'returns the current cursor position' do
        cursor = Cursor.new(attributes)
        cursor.position.must_equal([3, 3])
      end
    end

    describe '#move_up' do
      it 'does not move up when already at the top' do
        cursor = Cursor.new(attributes)
        cursor.move_up
        cursor.position.must_equal([3, 3])
      end

      it 'moves the cursor up' do
        cursor = Cursor.new(attributes)
        2.times { cursor.move_down }
        cursor.move_up
        cursor.position.must_equal([4, 3])
      end
    end

    describe '#move_down' do
      it 'moves the cursor down' do
        cursor = Cursor.new(attributes)
        cursor.move_down
        cursor.position.must_equal([4, 3])
      end

      it 'does not move down when already at the bottom' do
        cursor = Cursor.new(attributes)
        4.times { cursor.move_down }
        cursor.position.must_equal([6, 3])
      end
    end

    describe '#move_left' do
      it 'does not move left when already at leftmost' do
        cursor = Cursor.new(attributes)
        cursor.move_left
        cursor.position.must_equal([3, 3])
      end

      it 'moves the cursor left' do
        cursor = Cursor.new(attributes)
        2.times { cursor.move_right }
        cursor.move_left
        cursor.position.must_equal([3, 4])
      end
    end

    describe '#move_right' do
      it 'does not move right when already at rightmost' do
        cursor = Cursor.new(attributes)
        4.times { cursor.move_right }
        cursor.position.must_equal([3, 6])
      end

      it 'moves the cursor right' do
        cursor = Cursor.new(attributes)
        cursor.move_right
        cursor.position.must_equal([3, 4])
      end
    end

    describe '#show_cursor' do
      it 'sets the visible attribute to true' do
        cursor = Cursor.new(attributes)
        cursor.show_cursor
        cursor.visible.must_equal(true)
      end
    end

    describe '#hide_cursor' do
      it 'sets the visible attribute to false' do
        cursor = Cursor.new(attributes.merge!(cursor: true))
        cursor.hide_cursor
        cursor.visible.must_equal(false)
      end
    end
  end
end
