require 'test_helper'

module Vedeu

  module Geometry

    describe Geometry do

      let(:described)  { Vedeu::Geometry::Geometry }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          centred:    centred,
          client:     client,
          height:     height,
          maximised:  maximised,
          name:       _name,
          repository: Vedeu.geometries,
          width:      width,
          x:          x,
          xn:         xn,
          y:          y,
          yn:         yn,
        }
      }
      let(:centred)   { false }
      let(:client)    {}
      let(:height)    {}
      let(:maximised) { false }
      let(:_name)     { 'vedeu_geometry_geometry' }
      let(:width)     {}
      let(:x)         {}
      let(:xn)        {}
      let(:y)         {}
      let(:yn)        {}

      before { Vedeu::Terminal.stubs(:size).returns([12, 40]) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@centred').must_equal(centred) }
        it { instance.instance_variable_get('@client').must_equal(client) }
        it { instance.instance_variable_get('@height').must_equal(height) }
        it { instance.instance_variable_get('@maximised').must_equal(maximised) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@width').must_equal(width) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@xn').must_equal(xn) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@yn').must_equal(yn) }
        it do
          instance.instance_variable_get('@repository').
            must_equal(Vedeu.geometries)
        end
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:centred)
          instance.must_respond_to(:centred=)
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
          instance.must_respond_to(:height=)
          instance.must_respond_to(:maximised)
          instance.must_respond_to(:maximised?)
          instance.must_respond_to(:maximised=)
          instance.must_respond_to(:width=)
          instance.must_respond_to(:x=)
          instance.must_respond_to(:xn=)
          instance.must_respond_to(:y=)
          instance.must_respond_to(:yn=)
        }
      end

      describe '.store' do
        subject { described.store(attributes) }

        it { subject.must_equal(instance) }
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(name: 'other_geometry') }

          it { subject.must_equal(false) }
        end
      end

      describe '#maximise' do
        let(:attributes) {
          {
            height:    6,
            maximised: false,
            name:      'maximise',
            width:     18
          }
        }

        before { Vedeu.stubs(:trigger) }

        subject { instance.maximise }

        it { subject.must_be_instance_of(described) }
        it { subject.maximised.must_equal(true) }
      end

      describe '#move_down' do
        let(:x)  { 15 }
        let(:xn) { 25 }
        let(:y)  { 4 }
        let(:yn) { 8 }

        subject { instance.move_down }

        it { subject.must_be_instance_of(described) }

        it { subject.y.must_equal(5) }
        it { subject.yn.must_equal(9) }

        context 'when the move will make the geometry out of bounds' do
          let(:x)  { 15 }
          let(:xn) { 25 }
          let(:y)  { 8 }
          let(:yn) { 12 }

          it { subject.y.must_equal(8) }
          it { subject.yn.must_equal(12) }
        end
      end

      describe '#move_left' do
        let(:x)  { 15 }
        let(:xn) { 25 }
        let(:y)  { 4 }
        let(:yn) { 8 }

        subject { instance.move_left }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(14) }
        it { subject.xn.must_equal(24) }

        context 'when the move will make the geometry out of bounds' do
          let(:x)  { 1 }
          let(:xn) { 11 }
          let(:y)  { 4 }
          let(:yn) { 8 }

          it { subject.x.must_equal(1) }
          it { subject.xn.must_equal(11) }
        end
      end

      describe '#move_origin' do
        let(:x)  { 15 }
        let(:xn) { 25 }
        let(:y)  { 4 }
        let(:yn) { 8 }

        subject { instance.move_origin }

        it { subject.must_be_instance_of(described) }
        it { subject.x.must_equal(1) }
        it { subject.xn.must_equal(11) }
        it { subject.y.must_equal(1) }
        it { subject.yn.must_equal(5) }
      end

      describe '#move_right' do
        let(:x)  { 15 }
        let(:xn) { 25 }
        let(:y)  { 4 }
        let(:yn) { 8 }

        subject { instance.move_right }

        it { subject.must_be_instance_of(described) }

        it { subject.x.must_equal(16) }
        it { subject.xn.must_equal(26) }

        context 'when the move will make the geometry out of bounds' do
          let(:x)  { 30 }
          let(:xn) { 40 }
          let(:y)  { 4 }
          let(:yn) { 8 }

          it { subject.x.must_equal(30) }
          it { subject.xn.must_equal(40) }
        end
      end

      describe '#move_up' do
        let(:x)  { 15 }
        let(:xn) { 25 }
        let(:y)  { 4 }
        let(:yn) { 8 }

        subject { instance.move_up }

        it { subject.must_be_instance_of(described) }

        it { subject.y.must_equal(3) }
        it { subject.yn.must_equal(7) }

        context 'when the move will make the geometry out of bounds' do
          let(:x)  { 15 }
          let(:xn) { 25 }
          let(:y)  { 1 }
          let(:yn) { 5 }

          it { subject.y.must_equal(1) }
          it { subject.yn.must_equal(5) }
        end
      end

      describe '#unmaximise' do
        let(:attributes) {
          {
            height:    6,
            maximised: true,
            name:      'unmaximise',
            width:     18
          }
        }

        before { Vedeu.stubs(:trigger) }

        subject { instance.unmaximise }

        it { subject.must_be_instance_of(described) }
        it { subject.maximised.must_equal(false) }
      end

      describe '#top, #right, #bottom, #left' do
        context 'maximised is true' do
          let(:attributes) { { maximised: true } }

          it { instance.top.must_equal(1) }
          it { instance.right.must_equal(40) }
          it { instance.bottom.must_equal(12) }
          it { instance.left.must_equal(1) }
        end

        context 'centred is true' do
          let(:attributes) { { height: 6, width: 18, centred: true } }

          it { instance.top.must_equal(3) }
          it { instance.right.must_equal(29) }
          it { instance.bottom.must_equal(9) }
          it { instance.left.must_equal(11) }
        end

        context 'centred is true and y is set, y is ignored' do
          let(:attributes) { { height: 6, width: 18, centred: true, y: 4 } }

          it { instance.top.must_equal(3) }
          it { instance.right.must_equal(29) }
          it { instance.bottom.must_equal(9) }
          it { instance.left.must_equal(11) }
        end

        context 'centred is true and x is set, x is ignored' do
          let(:attributes) { { height: 6, width: 18, centred: true, x: 4 } }

          it { instance.top.must_equal(3) }
          it { instance.right.must_equal(29) }
          it { instance.bottom.must_equal(9) }
          it { instance.left.must_equal(11) }
        end

        context 'centred is false' do
          let(:attributes) { { height: 6, width: 18 } }

          it { instance.top.must_equal(1) }
          it { instance.right.must_equal(18) }
          it { instance.bottom.must_equal(6) }
          it { instance.left.must_equal(1) }
        end

        context 'centred is false and y is set' do
          let(:attributes) { { height: 6, width: 18, y: 4 } }

          it { instance.top.must_equal(4) }
          it { instance.right.must_equal(18) }
          it { instance.bottom.must_equal(9) }
          it { instance.left.must_equal(1) }
        end

        context 'centred is false and x is set' do
          let(:attributes) { { height: 6, width: 18, x: 4 } }

          it { instance.top.must_equal(1) }
          it { instance.right.must_equal(21) }
          it { instance.bottom.must_equal(6) }
          it { instance.left.must_equal(4) }
        end

        context 'maximised' do
          let(:attributes) { { maximised: true } }

          it { instance.top.must_equal(1) }
          it { instance.right.must_equal(40) }
          it { instance.bottom.must_equal(12) }
          it { instance.left.must_equal(1) }
        end
      end

      describe '#maximise' do
        let(:attributes) { { maximised: true } }

        subject { instance.maximise }

        it { instance.top.must_equal(1) }
        it { instance.right.must_equal(40) }
        it { instance.bottom.must_equal(12) }
        it { instance.left.must_equal(1) }
      end

      describe '#unmaximise' do
        let(:attributes) { { maximised: false } }

        subject { instance.unmaximise }

        it { instance.top.must_equal(1) }
        it { instance.right.must_equal(40) }
        it { instance.bottom.must_equal(12) }
        it { instance.left.must_equal(1) }
      end

    end # Geometry

  end # Geometry

end # Vedeu
