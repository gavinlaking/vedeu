require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/geometry'
require_relative '../../../../lib/vedeu/models/interface'

module Vedeu
  describe Geometry do
    describe '#origin' do
      it 'returns the origin for the interface' do
        interface = Interface.new({
          name:   'dummy',
          width:  5,
          height: 5,
          x:      1,
          y:      1,
          z:      1
        })
        Geometry.new(interface).origin.must_equal("\e[1;1H")
      end

      it 'returns the line position relative to the origin' do
        interface = Interface.new({
          name:   'dummy',
          width:  5,
          height: 5,
          x:      1,
          y:      1,
          z:      1
        })
        Geometry.new(interface).origin(3).must_equal("\e[4;1H")
      end

      it 'returns the origin for the interface when the interface is at a custom position' do
        interface = Interface.new({
          name:   'dummy',
          width:  5,
          height: 5,
          x:      3,
          y:      6,
          z:      1
        })
        Geometry.new(interface).origin.must_equal("\e[6;3H")
      end

      it 'returns the line position relative to the origin when the interface is at a custom position' do
        interface = Interface.new({
          name:   'dummy',
          width:  5,
          height: 5,
          x:      3,
          y:      6,
          z:      1
        })
        Geometry.new(interface).origin(3).must_equal("\e[9;3H")
      end

      it 'clips the maximum height to the terminal height when the height is more than the terminal height' do
        skip
        interface = Interface.new({
          name:   'dummy',
          width:  5,
          height: 6,
          x:      1,
          y:      20,
          z:      1
        })
        Geometry.new(interface).origin.must_equal("\e[1;1H")
      end

      it 'returns the value when the height is less than the terminal height' do
        skip
        interface = Interface.new({
          name:   'dummy',
          width:  5,
          height: 2,
          x:      1,
          y:      20,
          z:      1
        })
        Geometry.new(interface).origin.must_equal("\e[1;1H")
      end

      it 'clips the maximum width to the terminal width when the width is more than the terminal width' do
        interface = Interface.new({
          name:   'dummy',
          width:  20,
          height: 5,
          x:      30,
          y:      1,
          z:      1
        })
        Geometry.new(interface).origin.must_equal("\e[1;30H")
      end

      it 'returns the value when the width is less than the terminal width' do
        interface = Interface.new({
          name:   'dummy',
          width:  20,
          height: 5,
          x:      15,
          y:      1,
          z:      1
        })
        Geometry.new(interface).origin.must_equal("\e[1;15H")
      end
    end
  end
end
