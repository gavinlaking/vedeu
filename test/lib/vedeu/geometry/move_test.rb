require 'test_helper'

module Vedeu

  module Geometry

    describe Move do

      let(:described)  { Vedeu::Geometry::Move }
      let(:instance)   { described.new(attributes) }
      let(:direction)  {}
      let(:_name)      { 'Vedeu::Geometry::Move' }
      let(:offset)     {}
      let(:attributes) {
        {
          direction: direction,
          name:      _name,
          offset:    offset,
        }
      }
      let(:geometry)   {
        Vedeu::Geometry::Geometry.new(name: _name, x: 2, xn: 8, y: 2, yn: 8)
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when a direction is given' do
          let(:direction) { :left }

          it {
            instance.instance_variable_get('@direction').must_equal(direction)
          }
        end

        context 'when a direction is not given' do
          it { instance.instance_variable_get('@direction').must_equal(:none) }
        end

        context 'when a name is given' do
          it { instance.instance_variable_get('@name').must_equal(_name) }
        end

        context 'when a name is not given' do
          let(:_name) {}

          it { instance.instance_variable_get('@name').must_equal('') }
        end

        context 'when an offset is given' do
          let(:offset) { 2 }

          it { instance.instance_variable_get('@offset').must_equal(offset) }
        end

        context 'when an offset is not given' do
          it { instance.instance_variable_get('@offset').must_equal(1) }
        end
      end

      describe '.move' do
        before do
          Vedeu.geometries.stubs(:by_name).with(_name).returns(geometry)
          Vedeu.stubs(:trigger)
          Vedeu.stubs(:height).returns(10)
          Vedeu.stubs(:width).returns(10)
        end

        subject { described.move(attributes) }

        context 'when the direction is :down' do
          let(:direction) { :down }

          context 'when y + offset > terminal height' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when y + offset <= terminal height' do
            it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }
            it { subject.x.must_equal(2) }
            it { subject.xn.must_equal(8) }
            it { subject.y.must_equal(3) }
            it { subject.yn.must_equal(9) }
          end
        end

        context 'when the direction is :left' do
          let(:direction) { :left }

          context 'when x - offset < 1' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when x - offset >= 1' do
            it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }
            it { subject.x.must_equal(1) }
            it { subject.xn.must_equal(7) }
            it { subject.y.must_equal(2) }
            it { subject.yn.must_equal(8) }
          end
        end

        context 'when the direction is :none' do
          let(:direction) { :none }
          let(:offset)    { 1 }

          it { subject.must_equal(false) }
        end

        context 'when the direction is :origin' do
          let(:direction) { :origin }

          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }
          it { subject.x.must_equal(1) }
          it { subject.xn.must_equal(7) }
          it { subject.y.must_equal(1) }
          it { subject.yn.must_equal(7) }
        end

        context 'when the direction is :right' do
          let(:direction) { :right }

          context 'when xn + offset > terminal width' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when xn + offset <= terminal width' do
            it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }
            it { subject.x.must_equal(3) }
            it { subject.xn.must_equal(9) }
            it { subject.y.must_equal(2) }
            it { subject.yn.must_equal(8) }
          end
        end

        context 'when the direction is :up' do
          let(:direction) { :up }

          context 'when y - offset < 1' do
            let(:offset) { 3 }

            it { subject.must_equal(false) }
          end

          context 'when y - offset >= 1' do
            it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }
            it { subject.x.must_equal(2) }
            it { subject.xn.must_equal(8) }
            it { subject.y.must_equal(1) }
            it { subject.yn.must_equal(7) }
          end
        end

        context 'when the direction is invalid' do
          let(:direction) { :invalid }
          let(:offset)    { 1 }

          it { subject.must_equal(false) }
        end
      end

      describe '#move' do
        it { instance.must_respond_to(:move) }
      end

    end # Move

  end # Geometry

end # Vedeu
