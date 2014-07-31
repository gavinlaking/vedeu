require 'test_helper'
require 'vedeu/support/geometry'

module Vedeu
  describe Geometry do
    describe '#origin' do
      it 'returns the origin for the interface' do
        geometry = Geometry.new({ width: 5, height: 5, centred: false })
        geometry.origin.must_equal("\e[1;1H")
      end

      it 'returns the origin for the interface' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ width: 5, height: 5 })
          geometry.origin.must_equal("\e[10;38H")
        end
      end

      it 'returns the line position relative to the origin' do
        geometry = Geometry.new({ width: 5, height: 5, centred: false })
        geometry.origin(3).must_equal("\e[4;1H")
      end

      it 'returns the origin for the interface when the interface' \
         ' is at a custom position' do
        geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6, centred: false })
        geometry.origin.must_equal("\e[6;3H")
      end

      it 'returns the line position relative to the origin when the' \
         ' interface is at a custom position' do
        geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6, centred: false })
        geometry.origin(3).must_equal("\e[9;3H")
      end
    end

    describe '#terminal_height' do
      it 'raises an exception when the value is less than 1' do
        geometry = Geometry.new({ height: 6, width: 18, terminal_height: -2 })
        proc { geometry.terminal_height }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception when the value is greater than the terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, terminal_height: 30 })
          proc { geometry.terminal_height }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of terminal_height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, terminal_height: 20 })
          geometry.terminal_height.must_equal(20)
        end
      end

      it 'returns the default height when not set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
          geometry.terminal_height.must_equal(25)
        end
      end
    end

    describe '#height' do
      it 'raises an exception when the height attribute is not set' do
        proc { Geometry.new({ width: 18 }).height }.must_raise(InvalidHeight)
      end

      it 'raises an exception when the value is less than 1' do
        geometry = Geometry.new({ height: -6, width: 18 })
        proc { geometry.height }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception when the value is greater than the terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 30, width: 18 })
          proc { geometry.height }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of height' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.height.must_equal(6)
      end
    end

    describe '#y' do
      it 'raises an exception when the value is less than 1' do
        geometry = Geometry.new({ height: 6, width: 18, y: -2 })
        proc { geometry.y }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception when the value is greater than the terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, y: 30 })
          proc { geometry.y }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of y' do
        geometry = Geometry.new({ height: 6, width: 18, y: 6 })
        geometry.y.must_equal(6)
      end

      it 'returns 1 when not set' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.y.must_equal(1)
      end
    end

    describe '#terminal_width' do
      it 'raises an exception when the value is less than 1' do
        geometry = Geometry.new({ height: 6, width: 18, terminal_width: -2 })
        proc { geometry.terminal_width }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception when the value is greater than the terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, terminal_width: 85 })
          proc { geometry.terminal_width }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of terminal_width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, terminal_width: 40 })
          geometry.terminal_width.must_equal(40)
        end
      end

      it 'returns the default width when not set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
          geometry.terminal_width.must_equal(80)
        end
      end
    end

    describe '#width' do
      it 'raises an exception when the width attribute is not set' do
        proc { Geometry.new({ height: 6 }).width }.must_raise(InvalidWidth)
      end

      it 'raises an exception when the value is less than 1' do
        geometry = Geometry.new({ height: 6, width: -18 })
        proc { geometry.width }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception when the value is greater than the terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 85 })
          proc { geometry.width }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of width' do
        geometry = Geometry.new({ height: 6, width: 18, x: 6 })
        geometry.width.must_equal(18)
      end
    end

    describe '#x' do
      it 'raises an exception when the value is less than 1' do
        geometry = Geometry.new({ height: 6, width: 18, x: -2 })
        proc { geometry.x }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception when the value is greater than the terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, x: 85 })
          proc { geometry.x }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of x' do
        geometry = Geometry.new({ height: 6, width: 18, x: 6 })
        geometry.x.must_equal(6)
      end

      it 'returns 1 when not set' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.x.must_equal(1)
      end
    end

    describe '#centered' do
      it 'has a centred attribute' do
        geometry = Geometry.new({ height: 6, width: 18, centred: false })
        geometry.centred.must_equal(false)
      end

      it 'sets the centred attribute to true when not set' do
        geometry = Geometry.new({ height: 6, width: 18 })
        geometry.centred.must_equal(true)
      end
    end

    describe '#centre' do
      it 'returns a tuple containing the default centre coordinates' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
          geometry.centre.must_equal([12, 40])
        end
      end

      it 'returns a tuple containing the centre coordinates' do
        geometry = Geometry.new({ height: 6, width: 18, terminal_height: 12, terminal_width: 40 })
        geometry.centre.must_equal([6, 20])
      end

      it 'returns a tuple containing the centre coordinates when an' \
         ' alternative terminal height is set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, terminal_height: 12 })
          geometry.centre.must_equal([6, 40])
        end
      end

      it 'returns a tuple containing the centre coordinates when an' \
         ' alternative terminal width is set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18, terminal_width: 40 })
          geometry.centre.must_equal([12, 20])
        end
      end
    end

    describe '#top' do
      it 'centred is true and terminal height is set' do
        geometry = Geometry.new({ height: 6, width: 18, terminal_height: 12 })
        geometry.top.must_equal(3)
      end

      it 'centred is true and with default terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
          geometry.top.must_equal(9)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18, centred: false })
        geometry.top.must_equal(1)
      end

      it 'centred is false and y is set' do
        geometry = Geometry.new({ height: 6, width: 18, y: 4, centred: false })
        geometry.top.must_equal(4)
      end
    end

    describe '#left' do
      it 'centred is true and terminal width is set' do
        geometry = Geometry.new({ height: 6, width: 18, terminal_width: 40 })
        geometry.left.must_equal(11)
      end

      it 'centred is true and with default terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
          geometry.left.must_equal(31)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18, centred: false })
        geometry.left.must_equal(1)
      end

      it 'centred is false and x is set' do
        geometry = Geometry.new({ height: 6, width: 18, x: 5, centred: false })
        geometry.left.must_equal(5)
      end
    end

    describe '#bottom' do
      it 'centred is true and terminal height is set' do
        geometry = Geometry.new({ height: 6, width: 18, terminal_height: 12 })
        geometry.bottom.must_equal(9)
      end

      it 'centred is true and with default terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
          geometry.bottom.must_equal(15)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18, centred: false })
        geometry.bottom.must_equal(7)
      end

      it 'centred is false and y is set' do
        geometry = Geometry.new({ height: 6, width: 18, y: 5, centred: false })
        geometry.bottom.must_equal(11)
      end
    end

    describe '#right' do
      it 'centred is true and terminal width is set' do
        geometry = Geometry.new({ height: 6, width: 18, terminal_width: 40 })
        geometry.right.must_equal(29)
      end

      it 'centred is true and with default terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
          geometry.right.must_equal(49)
        end
      end

      it 'centred is false' do
        geometry = Geometry.new({ height: 6, width: 18, centred: false })
        geometry.right.must_equal(19)
      end

      it 'centred is false and x is set' do
        geometry = Geometry.new({ height: 6, width: 18, x: 5, centred: false })
        geometry.right.must_equal(23)
      end
    end

    describe '#position' do
      it 'centred is true' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          geometry = Geometry.new({ height: 6, width: 18 })
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
        geometry = Geometry.new({ height: 6, width: 18, x: 7, centred: false })
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
        geometry = Geometry.new({ height: 6, width: 18, y: 5, centred: false })
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
        geometry = Geometry.new({ height: 6, width: 18, centred: false })
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
