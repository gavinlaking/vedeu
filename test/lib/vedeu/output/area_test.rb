require 'test_helper'

module Vedeu
  describe Area do
    let(:area)   { Area.new(1, 1, 3, 3) }
    let(:y)      { 1 }
    let(:x)      { 1 }
    let(:height) { 3 }
    let(:width)  { 3 }

    describe '#initialize' do
      it 'returns an instance of itself' do
        area.must_be_instance_of(Area)
      end

      it 'sets instance variables' do
        area.instance_variable_get('@y').must_equal(y)
        area.instance_variable_get('@x').must_equal(x)
        area.instance_variable_get('@height').must_equal(height)
        area.instance_variable_get('@width').must_equal(width)
      end
    end

    describe '#range_y' do
      let(:area) { Area.new(7, 1, 4, 3) }

      it 'returns the actual y range' do
        area.range_y.must_equal([7, 8, 9, 10])
      end

      context 'when the height is 0' do
        let(:area) { Area.new(7, 1, 0, 3) }

        it 'returns an empty range' do
          area.range_y.must_equal([])
        end
      end
    end

    describe '#range_x' do
      let(:area) { Area.new(1, 4, 3, 10) }

      it 'returns the actual x range' do
        area.range_x.must_equal([4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
      end

      context 'when the width is 0' do
        let(:area) { Area.new(1, 4, 3, 0) }

        it 'returns an empty range' do
          area.range_x.must_equal([])
        end
      end
    end

    describe '#indexed_y' do
      let(:area) { Area.new(7, 1, 4, 3) }

      it 'returns the indexed y range' do
        area.indexed_y.must_equal([0, 1, 2, 3])
      end

      context 'when the height is 0' do
        let(:area) { Area.new(7, 1, 0, 3) }

        it 'returns an empty range' do
          area.indexed_y.must_equal([])
        end
      end
    end

    describe '#indexed_x' do
      let(:area) { Area.new(1, 4, 3, 10) }

      it 'returns the indexed x range' do
        area.indexed_x.must_equal([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
      end

      context 'when the width is 0' do
        let(:area) { Area.new(7, 1, 3, 0) }

        it 'returns an empty range' do
          area.indexed_x.must_equal([])
        end
      end
    end

    describe '#max_y' do
      context 'when the height is > 0' do
        let(:area) { Area.new(7, 1, 3, 6) }

        it { area.max_y.must_equal(10) }
      end

      context 'when the height is 0' do
        let(:area) { Area.new(7, 1, 0, 6) }

        it { area.max_y.must_equal(0) }
      end
    end

    describe '#max_x' do
      context 'when the width is > 0' do
        let(:area) { Area.new(9, 1, 3, 6) }

        it { area.max_x.must_equal(7) }
      end

      context 'when the width is 0' do
        let(:area) { Area.new(9, 1, 3, 0) }

        it { area.max_x.must_equal(0) }
      end
    end

    describe '#max_y_index' do
      context 'when the height is > 0' do
        let(:area) { Area.new(7, 1, 3, 6) }

        it { area.max_y_index.must_equal(2) }
      end

      context 'when the height is 0' do
        let(:area) { Area.new(7, 1, 0, 6) }

        it { area.max_y_index.must_equal(0) }
      end
    end

    describe '#max_x_index' do
      context 'when the width is > 0' do
        let(:area) { Area.new(9, 1, 3, 6) }

        it { area.max_x_index.must_equal(5) }
      end

      context 'when the width is 0' do
        let(:area) { Area.new(9, 1, 3, 0) }

        it { area.max_x_index.must_equal(0) }
      end
    end

    describe '#up' do
      let(:area) { Area.new(1, 1, 3, 3) }

      it 'returns a new instance of Area with y - 1' do
        result = area.up
        result.min_y.must_equal(0)
        result.max_y.must_equal(3)
      end

      it 'is chainable' do
        result = area.up.up.up
        result.min_y.must_equal(-2)
        result.max_y.must_equal(1)
      end
    end

    describe '#down' do
      let(:area)   { Area.new(1, 1, 3, 3) }

      it 'returns a new instance of Area with y + 1' do
        result = area.down
        result.min_y.must_equal(2)
        result.max_y.must_equal(5)
      end

      it 'is chainable' do
        result = area.down.down.down
        result.min_y.must_equal(4)
        result.max_y.must_equal(7)
      end
    end

    describe '#left' do
      let(:area)   { Area.new(1, 1, 3, 3) }

      it 'returns a new instance of Area with x - 1' do
        result = area.left
        result.min_x.must_equal(0)
        result.max_x.must_equal(3)
      end

      it 'is chainable' do
        result = area.left.left.left
        result.min_x.must_equal(-2)
        result.max_x.must_equal(1)
      end
    end

    describe '#right' do
      let(:area)   { Area.new(1, 1, 3, 3) }

      it 'returns a new instance of Area with x + 1' do
        result = area.right
        result.min_x.must_equal(2)
        result.max_x.must_equal(5)
      end

      it 'is chainable' do
        result = area.right.right.right
        result.min_x.must_equal(4)
        result.max_x.must_equal(7)
      end
    end

  end
end
