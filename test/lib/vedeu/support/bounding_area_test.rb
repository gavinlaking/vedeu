require 'test_helper'

module Vedeu

  describe BoundingArea do

    let(:height) { 15 }
    let(:width)  { 40 }
    let(:described_instance) { BoundingArea.new(height, width) }

    describe '#initialize' do
      it 'returns an instance of itself' do
        described_instance.must_be_instance_of(BoundingArea)
      end

      it 'assigns the height' do
        described_instance.instance_variable_get("@height").must_equal(height)
      end

      it 'assigns the width' do
        described_instance.instance_variable_get("@width").must_equal(width)
      end
    end

    describe '#height' do
      it 'returns the height' do
        described_instance.height.must_equal(height)
      end
    end

    describe '#width' do
      it 'returns the width' do
        described_instance.width.must_equal(width)
      end
    end

    describe '#top' do
      context 'when an offset is provided' do
        it 'returns the new top with the offset applied' do
          described_instance.top(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the height' do
          it 'returns the height' do
            described_instance.top(20).must_equal(15)
          end
        end

        context 'when the offset is less than or equal to 1' do
          it { described_instance.top(-1).must_equal(1) }
        end
      end

      context 'when an offset is not provided' do
        it { described_instance.top.must_equal(1) }
      end

      context 'alias_method #y' do
        it { described_instance.y.must_equal(1) }
      end
    end

    describe '#bottom' do
      context 'when an offset is provided' do
        it 'returns the new bottom with the offset applied' do
          described_instance.bottom(5).must_equal(10)
        end

        context 'when the offset is greater or equal to the height' do
          it { described_instance.bottom(30).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { described_instance.bottom(-1).must_equal(height) }
        end
      end

      context 'when an offset is not provided' do
        it { described_instance.bottom.must_equal(15) }
      end

      context 'alias_method #yn' do
        it { described_instance.yn.must_equal(15) }
      end
    end

    describe '#left' do
      context 'when an offset is provided' do
        it 'returns the new left with the offset applied' do
          described_instance.left(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the width' do
          it 'returns the width' do
            described_instance.left(50).must_equal(40)
          end
        end

        context 'when the offset is less than or equal to 1' do
          it { described_instance.left(-1).must_equal(1) }
        end
      end

      context 'when an offset is not provided' do
        it { described_instance.left.must_equal(1) }
      end

      context 'alias_method #x' do
        it { described_instance.x.must_equal(1) }
      end
    end

    describe '#right' do
      context 'when an offset is provided' do
        it 'returns the new right with the offset applied' do
          described_instance.right(5).must_equal(35)
        end

        context 'when the offset is greater or equal to the width' do
          it { described_instance.right(50).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { described_instance.right(-1).must_equal(40) }
        end
      end

      context 'when an offset is not provided' do
        it { described_instance.right.must_equal(40) }
      end

      context 'alias_method #xn' do
        it { described_instance.xn.must_equal(40) }
      end
    end

  end # BoundingArea

end # Vedeu
