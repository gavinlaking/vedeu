require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Vedeu::Output }
    let(:instance)  { described.new(interface) }
    let(:interface) {
      Vedeu.interface 'flourine' do
        geometry do
          height 3
          width  32
        end
      end
    }
    let(:lines) {
      [
        Line.new({ streams: [Stream.new({ value: 'this is the first' })] }),
        Line.new({ streams: [Stream.new({ value: 'this is the second and it is long' })] }),
        Line.new({ streams: [Stream.new({ value: 'this is the third, it is even longer and still truncated' })] }),
        Line.new({ streams: [Stream.new({ value: 'this should not render' })] }),
      ]
    }

    before do
      interface.lines = lines
      IO.console.stubs(:print)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@interface').must_equal(interface) }
    end

    describe '.render' do
      subject { described.render(interface) }

      it { subject.must_be_instance_of(Array) }

      context 'when a border is defined for the interface' do
      end

      context 'when a border is not defined for the interface' do
      end
    end

    # describe '#origin' do
    #   it 'returns the origin for the interface' do
    #     geometry = Geometry.new({ width: 5, height: 5 })
    #     geometry.origin.must_be_instance_of(Vedeu::Position)
    #     geometry.origin.y.must_equal(1)
    #     geometry.origin.x.must_equal(1)
    #   end

    #   it 'returns the origin for the interface' do
    #     geometry = Geometry.new({ width: 5, height: 5, centred: true })
    #     geometry.origin.must_be_instance_of(Vedeu::Position)
    #     geometry.origin.y.must_equal(10)
    #     geometry.origin.x.must_equal(38)
    #   end

    #   it 'returns the line position relative to the origin' do
    #     geometry = Geometry.new({ width: 5, height: 5 })
    #     geometry.origin(3).must_be_instance_of(Vedeu::Position)
    #     geometry.origin(3).y.must_equal(4)
    #     geometry.origin(3).x.must_equal(1)
    #   end

    #   it 'returns the origin for the interface when the interface' \
    #      ' is at a custom position' do
    #     geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6 })
    #     geometry.origin.must_be_instance_of(Vedeu::Position)
    #     geometry.origin.y.must_equal(6)
    #     geometry.origin.x.must_equal(3)
    #   end

    #   it 'returns the line position relative to the origin when the' \
    #      ' interface is at a custom position' do
    #     geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6 })
    #     geometry.origin(3).must_be_instance_of(Vedeu::Position)
    #     geometry.origin(3).y.must_equal(9)
    #     geometry.origin(3).x.must_equal(3)
    #   end
    # end

  end # Output

end # Vedeu
