require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/coordinate'

module Vedeu
  describe Coordinate do
    it 'raises an exception when the height attribute is not set' do
      proc { Coordinate.new({ width: 18 }) }.must_raise(KeyError)
    end

    it 'raises an exception when the width attribute is not set' do
      proc { Coordinate.new({ height: 6 }) }.must_raise(KeyError)
    end

    describe '#terminal_height' do
      it 'raises an exception if the value is less than 1' do
        coordinate = Coordinate.new({ height: 6, width: 18, terminal_height: -2 })
        proc { coordinate.terminal_height }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception if the value is greater than the terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18, terminal_height: 30 })
          proc { coordinate.terminal_height }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of terminal_height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          Coordinate.new({ height: 6, width: 18, terminal_height: 20 })
            .terminal_height.must_equal(20)
        end
      end

      it 'returns the default height if not set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          Coordinate.new({ height: 6, width: 18 })
            .instance_variable_get('@terminal_height').must_equal(25)
        end
      end
    end

    describe '#height' do
      it 'raises an exception if the value is less than 1' do
        coordinate = Coordinate.new({ height: -6, width: 18 })
        proc { coordinate.height }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception if the value is greater than the terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 30, width: 18 })
          proc { coordinate.height }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of height' do
        Coordinate.new({ height: 6, width: 18 }).height.must_equal(6)
      end
    end

    describe '#y' do
      it 'raises an exception if the value is less than 1' do
        coordinate = Coordinate.new({ height: 6, width: 18, y: -2 })
        proc { coordinate.y }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception if the value is greater than the terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18, y: 30 })
          proc { coordinate.y }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of y' do
        Coordinate.new({ height: 6, width: 18, y: 6 }).y.must_equal(6)
      end

      it 'returns 1 if not set' do
        Coordinate.new({ height: 6, width: 18 }).y.must_equal(1)
      end
    end

    describe '#terminal_width' do
      it 'raises an exception if the value is less than 1' do
        coordinate = Coordinate.new({ height: 6, width: 18, terminal_width: -2 })
        proc { coordinate.terminal_width }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception if the value is greater than the terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18, terminal_width: 85 })
          proc { coordinate.terminal_width }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of terminal_width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          Coordinate.new({ height: 6, width: 18, terminal_width: 40 })
            .terminal_width.must_equal(40)
        end
      end

      it 'returns the default width if not set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          Coordinate.new({ height: 6, width: 18 })
            .terminal_width.must_equal(80)
        end
      end
    end

    describe '#width' do
      it 'raises an exception if the value is less than 1' do
        coordinate = Coordinate.new({ height: 6, width: -18 })
        proc { coordinate.width }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception if the value is greater than the terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 85 })
          proc { coordinate.width }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of width' do
        Coordinate.new({ height: 6, width: 18, x: 6 }).width
          .must_equal(18)
      end
    end

    describe '#x' do
      it 'raises an exception if the value is less than 1' do
        coordinate = Coordinate.new({ height: 6, width: 18, x: -2 })
        proc { coordinate.x }.must_raise(OutOfBoundsError)
      end

      it 'raises an exception if the value is greater than the terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18, x: 85 })
          proc { coordinate.x }.must_raise(OutOfBoundsError)
        end
      end

      it 'returns the value of x' do
        Coordinate.new({ height: 6, width: 18, x: 6 }).x.must_equal(6)
      end

      it 'returns 1 if not set' do
        Coordinate.new({ height: 6, width: 18 }).x.must_equal(1)
      end
    end

    describe '#centered' do
      it 'has a centred attribute' do
        Coordinate.new({ height: 6, width: 18, centred: false })
          .centred.must_equal(false)
      end

      it 'sets the centred attribute to true if not set' do
        Coordinate.new({ height: 6, width: 18 })
          .centred.must_equal(true)
      end
    end

    describe '#centre' do
      it 'returns a tuple containing the default centre coordinates' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18 })
          coordinate.centre.must_equal([12, 40])
        end
      end

      it 'returns a tuple containing the centre coordinates' do
        coordinate = Coordinate.new({ height: 6, width: 18, terminal_height: 12, terminal_width: 40 })
        coordinate.centre.must_equal([6, 20])
      end

      it 'returns a tuple containing the centre coordinates when an' \
         ' alternative terminal height is set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18, terminal_height: 12 })
          coordinate.centre.must_equal([6, 40])
        end
      end

      it 'returns a tuple containing the centre coordinates when an' \
         ' alternative terminal width is set' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18, terminal_width: 40 })
          coordinate.centre.must_equal([12, 20])
        end
      end
    end

    describe '#top' do
      it 'centred is true and terminal height is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, terminal_height: 12 })
        coordinate.top.must_equal(3)
      end

      it 'centred is true and with default terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18 })
          coordinate.top.must_equal(9)
        end
      end

      it 'centred is false' do
        coordinate = Coordinate.new({ height: 6, width: 18, centred: false })
        coordinate.top.must_equal(1)
      end

      it 'centred is false and y is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, y: 4, centred: false })
        coordinate.top.must_equal(4)
      end
    end

    describe '#left' do
      it 'centred is true and terminal width is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, terminal_width: 40 })
        coordinate.left.must_equal(11)
      end

      it 'centred is true and with default terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18 })
          coordinate.left.must_equal(31)
        end
      end

      it 'centred is false' do
        coordinate = Coordinate.new({ height: 6, width: 18, centred: false })
        coordinate.left.must_equal(1)
      end

      it 'centred is false and x is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, x: 5, centred: false })
        coordinate.left.must_equal(5)
      end
    end

    describe '#bottom' do
      it 'centred is true and terminal height is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, terminal_height: 12 })
        coordinate.bottom.must_equal(9)
      end

      it 'centred is true and with default terminal height' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18 })
          coordinate.bottom.must_equal(15)
        end
      end

      it 'centred is false' do
        coordinate = Coordinate.new({ height: 6, width: 18, centred: false })
        coordinate.bottom.must_equal(7)
      end

      it 'centred is false and y is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, y: 5, centred: false })
        coordinate.bottom.must_equal(11)
      end
    end

    describe '#right' do
      it 'centred is true and terminal width is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, terminal_width: 40 })
        coordinate.right.must_equal(29)
      end

      it 'centred is true and with default terminal width' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18 })
          coordinate.right.must_equal(49)
        end
      end

      it 'centred is false' do
        coordinate = Coordinate.new({ height: 6, width: 18, centred: false })
        coordinate.right.must_equal(19)
      end

      it 'centred is false and x is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, x: 5, centred: false })
        coordinate.right.must_equal(23)
      end
    end

    describe '#position' do
      it 'centred is true' do
        console = IO.console
        console.stub :winsize, [25, 80] do
          coordinate = Coordinate.new({ height: 6, width: 18 })
          coordinate.position.must_equal({
            y:       9,
            x:       31,
            height:  6,
            width:   18,
            centred: true,
            bottom:  15,
            right:   49,
          })
        end
      end

      it 'centred is false and x is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, x: 7, centred: false })
        coordinate.position.must_equal({
          y:       1,
          x:       7,
          height:  6,
          width:   18,
          centred: false,
          bottom:  7,
          right:   25,
        })
      end

      it 'centred is false and y is set' do
        coordinate = Coordinate.new({ height: 6, width: 18, y: 5, centred: false })
        coordinate.position.must_equal({
          y:       5,
          x:       1,
          height:  6,
          width:   18,
          centred: false,
          bottom:  11,
          right:   19,
        })
      end

      it 'centred is false' do
        coordinate = Coordinate.new({ height: 6, width: 18, centred: false })
        coordinate.position.must_equal({
          y:       1,
          x:       1,
          height:  6,
          width:   18,
          centred: false,
          bottom:  7,
          right:   19,
        })
      end
    end
  end
end
