require 'test_helper'
require 'vedeu/models/geometry'

module Vedeu
  describe Geometry do
    describe '#origin' do
      it 'returns the origin for the interface' do
        geometry = Geometry.new({ width: 5, height: 5 })
        geometry.origin.must_equal("\e[1;1H")
      end

      it 'returns the origin for the interface' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ width: 5, height: 5, centred: true })
          geometry.origin.must_equal("\e[10;38H")
        end
      end

      it 'returns the line position relative to the origin' do
        geometry = Geometry.new({ width: 5, height: 5 })
        geometry.origin(3).must_equal("\e[4;1H")
      end

      it 'returns the origin for the interface when the interface' \
         ' is at a custom position' do
        geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6 })
        geometry.origin.must_equal("\e[6;3H")
      end

      it 'returns the line position relative to the origin when the' \
         ' interface is at a custom position' do
        geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6 })
        geometry.origin(3).must_equal("\e[9;3H")
      end
    end

    describe '#top' do
      it 'centred is true' do
        console = IO.console
        console.stub :winsize, [12, 80] do
          geometry = Geometry.new({ height: 6, width: 18, centred: true })
          geometry.top.must_equal(3)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.top.must_equal(1)
      end

      it 'centred is false and y is set' do
        geometry = Geometry.new({ height: 6, width: 18, y: 4 })
        geometry.top.must_equal(4)
      end
    end

    describe '#north' do
      it 'returns the top minus the value when the value is provided' do
        geometry = Geometry.new({ height: 6, width: 18, y: 4 })
        geometry.north(2).must_equal(2)
      end

      it 'returns the top minus 1 without a value' do
        geometry = Geometry.new({ height: 6, width: 18, y: 4 })
        geometry.north.must_equal(3)
      end
    end

    describe '#left' do
      it 'centred is true' do
        console = IO.console
        console.stub :winsize, [25, 40] do
          geometry = Geometry.new({ height: 6, width: 18, centred: true })
          geometry.left.must_equal(11)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.left.must_equal(1)
      end

      it 'centred is false and x is set' do
        geometry = Geometry.new({ height: 6, width: 18, x: 5 })
        geometry.left.must_equal(5)
      end
    end

    describe '#west' do
      it 'returns the left minus the value when the value is provided' do
        geometry = Geometry.new({ height: 6, width: 18, x: 7 })
        geometry.west(2).must_equal(5)
      end

      it 'returns the left minus 1 without a value' do
        geometry = Geometry.new({ height: 6, width: 18, x: 7 })
        geometry.west.must_equal(6)
      end
    end

    describe '#bottom' do
      it 'centred is true' do
        console = IO.console
        console.stub :winsize, [20, 40] do
          geometry = Geometry.new({ height: 6, width: 18, centred: true })
          geometry.bottom.must_equal(13)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.bottom.must_equal(7)
      end

      it 'centred is false and y is set' do
        geometry = Geometry.new({ height: 6, width: 18, y: 5 })
        geometry.bottom.must_equal(11)
      end
    end

    describe '#south' do
      it 'returns the bottom plus the value when the value is provided' do
        geometry = Geometry.new({ height: 6, width: 18, y: 3 })
        geometry.south(2).must_equal(11)
      end

      it 'returns the bottom plus 1 without a value' do
        geometry = Geometry.new({ height: 6, width: 18, y: 3 })
        geometry.south.must_equal(10)
      end
    end

    describe '#right' do
      it 'centred is true' do
        console = IO.console
        console.stub :winsize, [25, 40] do
          geometry = Geometry.new({ height: 6, width: 18, centred: true })
          geometry.right.must_equal(29)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.right.must_equal(19)
      end

      it 'centred is false and x is set' do
        geometry = Geometry.new({ height: 6, width: 18, x: 5 })
        geometry.right.must_equal(23)
      end
    end

    describe '#east' do
      it 'returns the right plus the value when the value is provided' do
        geometry = Geometry.new({ height: 6, width: 18, x: 7 })
        geometry.east(2).must_equal(27)
      end

      it 'returns the right plus 1 without a value' do
        geometry = Geometry.new({ height: 6, width: 18, x: 7 })
        geometry.east.must_equal(26)
      end
    end

    describe '#position' do
      it 'centred is true' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, centred: true })
          geometry.position.must_equal({
            y:       9,
            x:       31,
            height:  6,
            width:   18,
            centred: true,
            top:     9,
            bottom:  15,
            left:    31,
            right:   49,
          })
        end
      end

      it 'centred is false and x is set' do
        geometry = Geometry.new({ height: 6, width: 18, x: 7 })
        geometry.position.must_equal({
          y:       1,
          x:       7,
          height:  6,
          width:   18,
          centred: false,
          top:     1,
          bottom:  7,
          left:    7,
          right:   25,
        })
      end

      it 'centred is false and y is set' do
        geometry = Geometry.new({ height: 6, width: 18, y: 5 })
        geometry.position.must_equal({
          y:       5,
          x:       1,
          height:  6,
          width:   18,
          centred: false,
          top:     5,
          bottom:  11,
          left:    1,
          right:   19,
        })
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.position.must_equal({
          y:       1,
          x:       1,
          height:  6,
          width:   18,
          centred: false,
          top:     1,
          bottom:  7,
          left:    1,
          right:   19,
        })
      end
    end
  end
end
