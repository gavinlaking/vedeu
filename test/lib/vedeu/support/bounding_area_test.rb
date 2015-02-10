require 'test_helper'

module Vedeu

  describe BoundingArea do

    let(:described) { BoundingArea.new(height, width) }
    let(:height)    { 15 }
    let(:width)     { 40 }

    describe '#initialize' do
      it { described.must_be_instance_of(BoundingArea) }
      it { described.instance_variable_get('@height').must_equal(height) }
      it { described.instance_variable_get('@width').must_equal(width) }
    end

    describe '#height' do
      it 'returns the height' do
        described.height.must_equal(height)
      end
    end

    describe '#width' do
      it 'returns the width' do
        described.width.must_equal(width)
      end
    end

    describe '#top' do
      context 'when an offset is provided' do
        it 'returns the new top with the offset applied' do
          described.top(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the height' do
          it 'returns the height' do
            described.top(20).must_equal(15)
          end
        end

        context 'when the offset is less than or equal to 1' do
          it { described.top(-1).must_equal(1) }
        end
      end

      context 'when an offset is not provided' do
        it { described.top.must_equal(1) }
      end

      context 'alias_method #y' do
        it { described.y.must_equal(1) }
      end
    end

    describe '#bottom' do
      context 'when an offset is provided' do
        it 'returns the new bottom with the offset applied' do
          described.bottom(5).must_equal(10)
        end

        context 'when the offset is greater or equal to the height' do
          it { described.bottom(30).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { described.bottom(-1).must_equal(height) }
        end
      end

      context 'when an offset is not provided' do
        it { described.bottom.must_equal(15) }
      end

      context 'alias_method #yn' do
        it { described.yn.must_equal(15) }
      end
    end

    describe '#left' do
      context 'when an offset is provided' do
        it 'returns the new left with the offset applied' do
          described.left(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the width' do
          it 'returns the width' do
            described.left(50).must_equal(40)
          end
        end

        context 'when the offset is less than or equal to 1' do
          it { described.left(-1).must_equal(1) }
        end
      end

      context 'when an offset is not provided' do
        it { described.left.must_equal(1) }
      end

      context 'alias_method #x' do
        it { described.x.must_equal(1) }
      end
    end

    describe '#right' do
      context 'when an offset is provided' do
        it 'returns the new right with the offset applied' do
          described.right(5).must_equal(35)
        end

        context 'when the offset is greater or equal to the width' do
          it { described.right(50).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { described.right(-1).must_equal(40) }
        end
      end

      context 'when an offset is not provided' do
        it { described.right.must_equal(40) }
      end

      context 'alias_method #xn' do
        it { described.xn.must_equal(40) }
      end
    end

  end # BoundingArea

end # Vedeu
