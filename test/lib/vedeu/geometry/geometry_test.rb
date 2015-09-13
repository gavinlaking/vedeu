require 'test_helper'

module Vedeu

  module Geometry

    describe Geometry do

      let(:described)  { Vedeu::Geometry::Geometry }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          centred:    centred,
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
      let(:height)    {}
      let(:maximised) { false }
      let(:_name)     {}
      let(:width)     {}
      let(:x)         {}
      let(:xn)        {}
      let(:y)         {}
      let(:yn)        {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }
        it { instance.instance_variable_get('@centred').must_equal(centred) }
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
        it { instance.must_respond_to(:centred) }
        it { instance.must_respond_to(:centred=) }
        it { instance.must_respond_to(:attributes) }
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:name=) }
        it { instance.must_respond_to(:height=) }
        it { instance.must_respond_to(:maximised) }
        it { instance.must_respond_to(:maximised?) }
        it { instance.must_respond_to(:maximised=) }
        it { instance.must_respond_to(:width=) }
        it { instance.must_respond_to(:x=) }
        it { instance.must_respond_to(:xn=) }
        it { instance.must_respond_to(:y=) }
        it { instance.must_respond_to(:yn=) }
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
        before { Terminal.stubs(:size).returns([12, 40]) }

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

        before { Terminal.stubs(:size).returns([12, 40]) }

        subject { instance.maximise }

        it { instance.top.must_equal(1) }
        it { instance.right.must_equal(40) }
        it { instance.bottom.must_equal(12) }
        it { instance.left.must_equal(1) }
      end

      describe '#unmaximise' do
        let(:attributes) { { maximised: false } }

        before { Terminal.stubs(:size).returns([12, 40]) }

        subject { instance.unmaximise }

        it { instance.top.must_equal(1) }
        it { instance.right.must_equal(40) }
        it { instance.bottom.must_equal(12) }
        it { instance.left.must_equal(1) }
      end

    end # Geometry

  end # Geometry

end # Vedeu
