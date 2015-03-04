require 'test_helper'

module Vedeu

  describe BoundingArea do

    let(:described) { Vedeu::BoundingArea }
    let(:instance)  { described.new(height, width) }
    let(:height)    { 15 }
    let(:width)     { 40 }

    describe 'alias methods' do
      it { instance.must_respond_to(:y) }
      it { instance.must_respond_to(:yn) }
      it { instance.must_respond_to(:x) }
      it { instance.must_respond_to(:xn) }
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(BoundingArea) }
      it { instance.instance_variable_get('@height').must_equal(height) }
      it { instance.instance_variable_get('@width').must_equal(width) }
    end

    describe '#height' do
      it 'returns the height' do
        instance.height.must_equal(height)
      end
    end

    describe '#width' do
      it 'returns the width' do
        instance.width.must_equal(width)
      end
    end

    describe '#top' do
      context 'when an offset is provided' do
        it 'returns the new top with the offset applied' do
          instance.top(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the height' do
          it 'returns the height' do
            instance.top(20).must_equal(15)
          end
        end

        context 'when the offset is less than or equal to 1' do
          it { instance.top(-1).must_equal(1) }
        end
      end

      context 'when an offset is not provided' do
        it { instance.top.must_equal(1) }
      end
    end

    describe '#bottom' do
      context 'when an offset is provided' do
        it 'returns the new bottom with the offset applied' do
          instance.bottom(5).must_equal(10)
        end

        context 'when the offset is greater or equal to the height' do
          it { instance.bottom(30).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { instance.bottom(-1).must_equal(height) }
        end
      end

      context 'when an offset is not provided' do
        it { instance.bottom.must_equal(15) }
      end
    end

    describe '#left' do
      context 'when an offset is provided' do
        it 'returns the new left with the offset applied' do
          instance.left(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the width' do
          it 'returns the width' do
            instance.left(50).must_equal(40)
          end
        end

        context 'when the offset is less than or equal to 1' do
          it { instance.left(-1).must_equal(1) }
        end
      end

      context 'when an offset is not provided' do
        it { instance.left.must_equal(1) }
      end
    end

    describe '#right' do
      context 'when an offset is provided' do
        it 'returns the new right with the offset applied' do
          instance.right(5).must_equal(35)
        end

        context 'when the offset is greater or equal to the width' do
          it { instance.right(50).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { instance.right(-1).must_equal(40) }
        end
      end

      context 'when an offset is not provided' do
        it { instance.right.must_equal(40) }
      end
    end

  end # BoundingArea

end # Vedeu
