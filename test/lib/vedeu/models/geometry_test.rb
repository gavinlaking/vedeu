require 'test_helper'

module Vedeu

  describe Geometry do

    let(:described)  { Geometry.new(attributes) }
    let(:instance)   { Geometry.new(attributes) }
    let(:attributes) { {} }

    before do
      IO.console.stubs(:winsize).returns([25, 80])
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(Geometry) }

      context 'with default attributes' do
        it { instance.instance_variable_get('@attributes').must_equal({
            centred: false,
            client:  nil,
            height:  25,
            name:    '',
            width:   80,
            x:       1,
            xn:      80,
            y:       1,
            yn:      25,
          })
        }
        it { instance.instance_variable_get('@centred').must_equal(false) }
        it { instance.instance_variable_get('@height').must_equal(25) }
        it { instance.instance_variable_get('@name').must_equal('') }
        it { instance.instance_variable_get('@width').must_equal(80) }
        it { instance.instance_variable_get('@x').must_equal(1) }
        it { instance.instance_variable_get('@xn').must_equal(80) }
        it { instance.instance_variable_get('@y').must_equal(1) }
        it { instance.instance_variable_get('@yn').must_equal(25) }
        it { instance.instance_variable_get('@repository').must_equal(Vedeu.geometries) }
      end
    end

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_equal(
        '<Vedeu::Geometry (height:(25/24) width:(80/79) top:1 bottom:25 left:1 right:80)>'
      ) }
    end

    describe '#y' do
      subject { instance.y }

      context 'when it is a proc' do
        let(:attributes) { { y: proc { 17 } } }

        it { subject.must_equal(17) }
      end

      context 'when just an attribute' do
        let(:attributes) { { y: 19 } }

        it { subject.must_equal(19) }
      end
    end

    describe '#yn' do
      subject { instance.yn }

      context 'when it is a proc' do
        let(:attributes) { { yn: proc { 17 } } }

        it { subject.must_equal(17) }
      end

      context 'when just an attribute' do
        let(:attributes) { { yn: 19 } }

        it { subject.must_equal(19) }
      end
    end

    describe '#x' do
      it 'returns the value of x when it is a proc' do
        geometry = Geometry.new({ x: proc { 58 } })
        geometry.x.must_equal(58)
      end

      it 'returns the value of x when just an attribute' do
        geometry = Geometry.new({ x: 64 })
        geometry.x.must_equal(64)
      end
    end

    describe '#xn' do
      it 'returns the value of xn when it is a proc' do
        geometry = Geometry.new({ xn: proc { 58 } })
        geometry.xn.must_equal(58)
      end

      it 'returns the value of xn when just an attribute' do
        geometry = Geometry.new({ xn: 64 })
        geometry.xn.must_equal(64)
      end
    end

    describe '#width' do
      it 'returns the viewport width when the interface fits the terminal' do
        geometry = Geometry.new({ width: 60, height: 1, x: 5, y: 1 })
        geometry.width.must_equal(60)
      end

      it 'returns the viewport width when the interface does not fit the ' \
         'terminal' do
        IO.console.stub(:winsize, [25, 60]) do
          geometry = Geometry.new({ width: 60, height: 1, x: 5, y: 1 })
          geometry.width.must_equal(55)
        end
      end

      it 'returns an unusable viewport width when the terminal is tiny' do
        IO.console.stub(:winsize, [25, -10]) do
          geometry = Geometry.new({ width: 60, height: 1, x: 5, y: 1 })
          geometry.width.must_equal(1)
        end
      end
    end

    describe '#height' do
      it 'returns the viewport height when the interface fits the terminal' do
        geometry = Geometry.new({ width: 5, height: 20, x: 1, y: 5 })
        geometry.height.must_equal(20)
      end

      it 'returns the viewport height when the interface does not fit the ' \
         'terminal' do
        IO.console.stub(:winsize, [15, 80]) do
          geometry = Geometry.new({ width: 5, height: 20, x: 1, y: 5 })
          geometry.height.must_equal(10)
        end
      end

      it 'returns an unusable viewport height when the terminal is tiny' do
        IO.console.stub(:winsize, [-10, 80]) do
          geometry = Geometry.new({ width: 60, height: 20, x: 1, y: 5 })
          geometry.height.must_equal(1)
        end
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

  end # Geometry

end # Vedeu
