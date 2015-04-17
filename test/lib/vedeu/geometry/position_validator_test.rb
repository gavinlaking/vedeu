require 'test_helper'

module Vedeu

  describe PositionValidator do

    let(:described) { Vedeu::PositionValidator }
    let(:instance)  { described.new(_name, x, y) }
    let(:_name)     { 'position_validator' }
    let(:x)         { 1 }
    let(:y)         { 1 }
    let(:border)    {
      Vedeu::Border.new({
        name:    _name,
        enabled: enabled,
      })
    }
    let(:enabled) { true }
    let(:geometry)  {
      Vedeu::Geometry.new({
        name: _name,
        x:    5,
        xn:   35,
        y:    5,
        yn:   10
      })
    }

    before do
      IO.console.stubs(:size).returns([15, 40])
      Vedeu.borders.stubs(:by_name).returns(border)
      Vedeu.geometries.stubs(:by_name).returns(geometry)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '.validate' do
      subject { described.validate(_name, x, y) }

      it { instance.must_be_instance_of(described) }
    end

    describe '#y' do
      subject { described.validate(_name, x, y).y }

      context 'when y is less than ty' do
        let(:y) { -2 }

        it { subject.must_equal(6) }
      end

      context 'when y is less than top' do
        let(:y) { 2 }

        it { subject.must_equal(6) }
      end

      context 'when y is less than by' do
        let(:y) { 5 }

        it { subject.must_equal(6) }

        context 'when border is not enabled' do
          let(:enabled) { false }

          it { subject.must_equal(5) }
        end
      end

      context 'when y is more than tyn' do
        let(:y) { 17 }

        it { subject.must_equal(9) }
      end

      context 'when y is more than bottom' do
        let(:y) { 12 }

        it { subject.must_equal(9) }
      end

      context 'when y is more than byn' do
        let(:y) { 10 }

        it { subject.must_equal(9) }

        context 'when border is not enabled' do
          let(:enabled) { false }

          it { subject.must_equal(10) }
        end
      end
    end

    describe '#x' do
      subject { described.validate(_name, x, y).x }

      context 'when x is less than tx' do
        let(:x) { -2 }

        it { subject.must_equal(6) }
      end

      context 'when x is less than left' do
        let(:x) { 2 }

        it { subject.must_equal(6) }
      end

      context 'when x is less than bx' do
        let(:x) { 5 }

        it { subject.must_equal(6) }

        context 'when border is not enabled' do
          let(:enabled) { false }

          it { subject.must_equal(5) }
        end
      end

      context 'when x is more than txn' do
        let(:x) { 47 }

        it { subject.must_equal(34) }
      end

      context 'when x is more than right' do
        let(:x) { 37 }

        it { subject.must_equal(34) }
      end

      context 'when x is more than bxn' do
        let(:x) { 35 }

        it { subject.must_equal(34) }

        context 'when border is not enabled' do
          let(:enabled) { false }

          it { subject.must_equal(35) }
        end
      end
    end

  end # PositionValidator

end # Vedeu
