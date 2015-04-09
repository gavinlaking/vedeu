require 'test_helper'

module Vedeu

  describe Geometry do

    let(:described)  { Vedeu::Geometry }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        centred: centred,
        height:  height,
        name:    _name,
        width:   width,
        x:       x,
        xn:      xn,
        y:       y,
        yn:      yn,
      }
    }
    let(:centred) {}
    let(:height)  {}
    let(:_name)   {}
    let(:width)   {}
    let(:x)       {}
    let(:xn)      {}
    let(:y)       {}
    let(:yn)      {}

    before { Terminal.stubs(:size).returns([12, 40]) }

    describe '#initialize' do
      it { instance.must_be_instance_of(Geometry) }
      it { instance.instance_variable_get('@attributes').must_equal(attributes) }
      it { instance.instance_variable_get('@centred').must_equal(centred) }
      it { instance.instance_variable_get('@height').must_equal(height) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@width').must_equal(width) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@xn').must_equal(xn) }
      it { instance.instance_variable_get('@y').must_equal(y) }
      it { instance.instance_variable_get('@yn').must_equal(yn) }
      it do
        instance.instance_variable_get('@repository').must_equal(Vedeu.geometries)
      end
    end

    describe '#top, #right, #bottom, #left' do
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
    end

  end # Geometry

end # Vedeu
