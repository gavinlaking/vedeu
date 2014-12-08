require 'test_helper'

describe Fixnum do

  describe '#columns' do
    it 'returns the width if the value is in range' do
      IO.console.stub :winsize, [25, 60] do
        1.columns.must_equal(5)
      end
    end
  end

end # Fixnum

module Vedeu

  describe Grid do

    describe '.columns' do
      it 'raises an exception if the value is less than 1' do
        proc { Grid.columns(0) }.must_raise(OutOfRange)
      end

      it 'raises an exception if the value is greater than 12' do
        proc { Grid.columns(13) }.must_raise(OutOfRange)
      end

      it 'returns the width if the value is in range' do
        IO.console.stub :winsize, [25, 80] do
          Grid.columns(7).must_equal(42)
        end
      end
    end

  end # Grid

  describe ConsoleGeometry do
    let(:height) { 15 }
    let(:width)  { 40 }
    let(:described_instance) { ConsoleGeometry.new(height, width) }

    describe '#initialize' do
      subject { described_instance }

      it 'returns an instance of itself' do
        subject.must_be_instance_of(ConsoleGeometry)
      end

      it 'assigns the height' do
        subject.instance_variable_get("@height").must_equal(height)
      end

      it 'assigns the width' do
        subject.instance_variable_get("@width").must_equal(width)
      end
    end

    describe '#top' do
      context 'when an offset is provided' do
        it 'returns the new top with the offset applied' do
          described_instance.top(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the height - 1' do
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
    end

    describe '#bottom' do
      context 'when an offset is provided' do
        it 'returns the new bottom with the offset applied' do
          described_instance.bottom(5).must_equal(10)
        end

        context 'when the offset is greater or equal to the height - 1' do
          it { described_instance.bottom(30).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { described_instance.bottom(-1).must_equal(height) }
        end
      end

      context 'when an offset is not provided' do
        it { described_instance.bottom.must_equal(15) }
      end
    end

    describe '#left' do
      context 'when an offset is provided' do
        it 'returns the new left with the offset applied' do
          described_instance.left(5).must_equal(6)
        end

        context 'when the offset is greater or equal to the width - 1' do
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
    end

    describe '#right' do
      context 'when an offset is provided' do
        it 'returns the new right with the offset applied' do
          described_instance.right(5).must_equal(35)
        end

        context 'when the offset is greater or equal to the width - 1' do
          it { described_instance.right(50).must_equal(1) }
        end

        context 'when the offset is less than 0' do
          it { described_instance.right(-1).must_equal(40) }
        end
      end

      context 'when an offset is not provided' do
        it { described_instance.right.must_equal(40) }
      end
    end
  end

end # Vedeu
