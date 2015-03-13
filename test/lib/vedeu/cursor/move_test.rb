require 'test_helper'

module Vedeu

  describe Move do

    let(:described) { Vedeu::Move }
    let(:instance)  { described.new(cursor, interface, dy, dx) }
    let(:cursor)    {
      Cursor.new({ name: 'Move',
                   ox:    ox,
                   oy:    oy,
                   state: :show,
                   x:     x,
                   y:     y })
    }
    let(:ox)        { 0 }
    let(:oy)        { 0 }
    let(:x)         { 1 }
    let(:y)         { 1 }

    let(:interface) {
      Vedeu.interface 'magnesium' do
        geometry do

        end
      end
    }
    let(:interface_with_border) {
      Vedeu.interface 'manganese' do
        border do
          # ...
        end
        geometry do
          height 5
          width 5
          x 5
          y 5
        end
      end
    }
    let(:interface_without_border) {
      Vedeu.interface 'meitnerium' do
        geometry do
          height 5
          width 5
          x 5
          y 5
        end
      end
    }

    let(:dy)        { 0 }
    let(:dx)        { 0 }

    before do
      IO.console.stubs(:winsize).returns([25, 80])
      IO.console.stubs(:print)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Move) }
      it { instance.instance_variable_get('@cursor').must_equal(cursor) }
      it { instance.instance_variable_get('@interface').must_equal(interface) }
      it { instance.instance_variable_get('@dy').must_equal(dy) }
      it { instance.instance_variable_get('@dx').must_equal(dx) }
    end

    describe '.by_name' do
      let(:direction) { :down }
      let(:_name)     { 'manganese' }

      before do
        Vedeu.interfaces.reset
        Vedeu.cursors.reset

        interface_with_border
        Vedeu::Cursor.new({ name: 'manganese', oy: 2, ox: 3, x: 8, y: 7 }).store
      end

      subject { Move.by_name(direction, _name) }

      it { subject.must_be_instance_of(Vedeu::Cursor) }

      context 'when the name is not specified' do
        let(:_name) {}

      end

      context 'when the name is specified' do
        let(:_name) { 'manganese' }

        context 'and the direction is down' do
          let(:direction) { :down }

          it { subject.oy.must_equal(3) }
        end
        context 'and the direction is left' do
          let(:direction) { :left }

          it { subject.ox.must_equal(2) }
        end
        context 'and the direction is right' do
          let(:direction) { :right }

          it { subject.ox.must_equal(4) }
        end
        context 'and the direction is up' do
          let(:direction) { :up }

          it { subject.oy.must_equal(1) }
        end

        context 'but the interface does not exist' do
          before { Vedeu.interfaces.stubs(:find).with(_name).returns(nil) }

        end
      end
    end

    describe '.down' do
      subject { Move.down(cursor, interface) }

      it { subject.must_be_instance_of(Vedeu::Cursor) }

      it { subject.y.must_equal(2) }

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { Move.down(cursor, interface_without_border) }
        let(:y) { 15 }

        it 'does not move past the bottom of the interface' do
          subject.y.must_equal(6)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { Move.down(cursor, interface_with_border) }
        let(:y)         { 15 }

        it 'does not move past the bottom border' do
          subject.y.must_equal(6)
        end
      end
    end

    describe '.left' do
      subject { Move.left(cursor, interface) }

      it { subject.must_be_instance_of(Vedeu::Cursor) }

      it { subject.x.must_equal(1) }

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { Move.left(cursor, interface_without_border) }
        let(:x)         { 3 }

        it 'does not move past the left of the interface' do
          subject.x.must_equal(3)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { Move.left(cursor, interface_with_border) }
        let(:x)         { 4 }

        it 'does not move past the left border' do
          subject.x.must_equal(4)
        end
      end
    end

    describe '.right' do
      subject { Move.right(cursor, interface) }

      it { subject.must_be_instance_of(Vedeu::Cursor) }

      it { subject.x.must_equal(2) }

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { Move.right(cursor, interface_without_border) }
        let(:x)         { 14 }

        it 'does not move past the right of the interface' do
          subject.x.must_equal(6)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { Move.right(cursor, interface_with_border) }

        let(:x)         { 14 }

        it 'does not move past the right border' do
          subject.x.must_equal(6)
        end
      end
    end

    describe '.up' do
      subject { Move.up(cursor, interface) }

      it { subject.must_be_instance_of(Vedeu::Cursor) }

      it { subject.y.must_equal(1) }

      context 'when moving, the cursor must be within the boundary of the ' \
              'interface' do
        subject { Move.up(cursor, interface_without_border) }

        let(:y)         { 3 }

        it 'does not move past the top of the interface' do
          subject.y.must_equal(3)
        end
      end

      context 'when moving, the cursor must be within the border of the ' \
              'interface' do
        subject { Move.up(cursor, interface_with_border) }

        let(:y)         { 3 }

        it 'does not move past the top border' do
          subject.y.must_equal(3)
        end
      end
    end

    describe '#origin' do
      subject { Move.origin(cursor, interface) }

      it { subject.must_be_instance_of(Vedeu::Cursor) }

      context 'within the visible area for the console' do
        it { subject.x.must_equal(1) }
        it { subject.y.must_equal(1) }
      end

      context 'within the boundary of the interface' do
        subject { Move.origin(cursor, interface_without_border) }

        it { subject.x.must_equal(5) }
        it { subject.y.must_equal(5) }
      end

      context 'within the border of the interface' do
        subject { Move.origin(cursor, interface_with_border) }

        it { subject.x.must_equal(6) }
        it { subject.y.must_equal(6) }
      end
    end

    describe '#move' do
      subject { Move.new(cursor, interface, dy, dx).move }

      it { subject.must_be_instance_of(Vedeu::Cursor) }
    end

  end # Move

end # Vedeu
