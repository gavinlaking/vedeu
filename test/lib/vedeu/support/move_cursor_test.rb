require 'test_helper'

module Vedeu

  describe MoveCursor do

    let(:cursor)    { Cursor.new('MoveCursor', :show, x, y) }
    let(:x)         { 1 }
    let(:y)         { 1 }

    let(:interface) { Interface.new }
    let(:interface_with_border) {
      Interface.new({
        border: { enabled: true },
        geometry: { y: 5, height: 5, x: 5, width: 5 }
      })
    }
    let(:interface_without_border) {
      Interface.new({
        geometry: { y: 5, height: 5, x: 5, width: 5 }
      })
    }

    let(:dy)        { 0 }
    let(:dx)        { 0 }

    before { IO.console.stubs(:winsize).returns([25, 80]) }

    describe '#initialize' do
      subject { MoveCursor.new(cursor, interface, dy, dx) }

      it { return_type_for(subject, Vedeu::MoveCursor) }
      it { assigns(subject, '@cursor', cursor) }
      it { assigns(subject, '@interface', interface) }
      it { assigns(subject, '@dy', dy) }
      it { assigns(subject, '@dx', dx) }
    end

    describe '.down' do
      subject { MoveCursor.down(cursor, interface) }

      it { return_type_for(subject, Vedeu::Cursor) }

      it { return_value_for(subject.y, 2) }

      context 'when moving, the cursor must be within the visible area for ' \
              'the console' do
        let(:y) { 26 }

        it 'does not move past the bottom of the screen' do
          return_value_for(subject.y, 25)
        end
      end

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { MoveCursor.down(cursor, interface_without_border) }
        let(:y)         { 15 }

        it 'does not move past the bottom of the interface' do
          return_value_for(subject.y, 10)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { MoveCursor.down(cursor, interface_with_border) }
        let(:y)         { 15 }

        it 'does not move past the bottom border' do
          return_value_for(subject.y, 8)
        end
      end
    end

    describe '.left' do
      subject { MoveCursor.left(cursor, interface) }

      it { return_type_for(subject, Vedeu::Cursor) }

      it { return_value_for(subject.x, 1) }

      context 'when moving, the cursor must be within the visible area for ' \
              'the console' do
        let(:x) { -5 }

        it 'does not move past the left of the screen' do
          return_value_for(subject.x, 1)
        end
      end

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { MoveCursor.left(cursor, interface_without_border) }
        let(:x)         { 3 }

        it 'does not move past the left of the interface' do
          return_value_for(subject.x, 5)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { MoveCursor.left(cursor, interface_with_border) }
        let(:x)         { 4 }

        it 'does not move past the left border' do
          return_value_for(subject.x, 6)
        end
      end
    end

    describe '.right' do
      subject { MoveCursor.right(cursor, interface) }

      it { return_type_for(subject, Vedeu::Cursor) }

      it { return_value_for(subject.x, 2) }

      context 'when moving, the cursor must be within the visible area for ' \
              'the console' do
        let(:x) { 85 }

        it 'does not move past the right of the screen' do
          return_value_for(subject.x, 80)
        end
      end

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { MoveCursor.right(cursor, interface_without_border) }
        let(:x)         { 14 }

        it 'does not move past the right of the interface' do
          return_value_for(subject.x, 10)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { MoveCursor.right(cursor, interface_with_border) }

        let(:x)         { 14 }

        it 'does not move past the right border' do
          return_value_for(subject.x, 8)
        end
      end
    end

    describe '.up' do
      subject { MoveCursor.up(cursor, interface) }

      it { return_type_for(subject, Vedeu::Cursor) }

      it { return_value_for(subject.y, 1) }

      context 'when moving, the cursor must be within the visible area for ' \
              'the console' do
        let(:y) { -5 }

        it 'does not move past the top of the screen' do
          return_value_for(subject.y, 1)
        end
      end

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { MoveCursor.up(cursor, interface_without_border) }

        let(:y)         { 3 }

        it 'does not move past the top of the interface' do
          return_value_for(subject.y, 5)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { MoveCursor.up(cursor, interface_with_border) }

        let(:y)         { 3 }

        it 'does not move past the top border' do
          return_value_for(subject.y, 6)
        end
      end
    end

    describe '#origin' do
      subject { MoveCursor.origin(cursor, interface) }

      it { return_type_for(subject, Vedeu::Cursor) }

      context 'within the visible area for the console' do
        it { return_value_for(subject.x, 1) }
        it { return_value_for(subject.y, 1) }
      end

      context 'within the boundary of the interface' do
        subject { MoveCursor.origin(cursor, interface_without_border) }

        it { return_value_for(subject.x, 5) }
        it { return_value_for(subject.y, 5) }
      end

      context 'within the border of the interface' do
        subject { MoveCursor.origin(cursor, interface_with_border) }

        it { return_value_for(subject.x, 6) }
        it { return_value_for(subject.y, 6) }
      end
    end

    describe '#move' do
      subject { MoveCursor.new(cursor, interface, dy, dx).move }

      it { return_type_for(subject, Vedeu::Cursor) }
    end

  end # MoveCursor

end # Vedeu
