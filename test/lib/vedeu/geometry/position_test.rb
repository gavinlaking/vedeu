require 'test_helper'

module Vedeu

  module Geometry

    describe Position do

      let(:described) { Vedeu::Geometry::Position }
      let(:instance)  { described.new(y, x) }
      let(:y)         { 12 }
      let(:x)         { 19 }

      describe 'accessors' do
        it { instance.must_respond_to(:y) }
        it { instance.must_respond_to(:first) }
        it { instance.must_respond_to(:x) }
        it { instance.must_respond_to(:last) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@x').must_equal(x) }
      end

      describe '.[]' do
        subject { described.[](y, x) }

        it { instance.must_be_instance_of(described) }
      end

      describe '#<=>' do
        subject { instance.<=>(other) }

        context 'when y is the same as other.y' do
          context 'when x is the same as other.x' do
            let(:other) { described.new(12, 19) }

            it { subject.must_equal(0) }
          end

          context 'when x is different to other.x' do
            let(:other) { described.new(12, 21) }

            it { subject.must_equal(-1) }
          end
        end

        context 'when y is different to other.y' do
          let(:other) { described.new(14, 19) }

          it { subject.must_equal(-1) }
        end
      end

      describe '.coerce' do
        let(:_value) {}

        subject { described.coerce(_value) }

        context 'when the value is already a Position' do
          let(:_value) { instance }

          it { subject.must_equal(instance) }
        end

        context 'when the value is an Array' do
          let(:_value) { [2, 8] }

          it { subject.must_be_instance_of(described) }
          it { subject.y.must_equal(2) }
          it { subject.x.must_equal(8) }
        end

        context 'when the value is a Hash' do
          let(:_value) { { y: 3, x: 9 } }

          it { subject.must_be_instance_of(described) }
          it { subject.y.must_equal(3) }
          it { subject.x.must_equal(9) }
        end

        context 'when the value is something unhandled' do
          it { subject.must_be_instance_of(NilClass) }
        end
      end

      describe '#eql?' do
        let(:other) { described.new(12, 19) }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(2, 9) }

          it { subject.must_equal(false) }
        end
      end

      describe '#to_a' do
        subject { Vedeu::Geometry::Position.new.to_a }

        it { subject.must_equal([1, 1]) }
      end

      describe '#to_position' do
        subject { instance.to_position }

        it { subject.must_be_instance_of(Vedeu::Geometry::Position) }
        it { subject.must_equal(instance) }
      end

      describe '#to_s' do
        # subject { described.new.to_s }

        it 'returns an escape sequence when no coordinates are provided' do
          Vedeu::Geometry::Position.new.to_s.must_equal("\e[1;1H")
        end

        it 'returns an escape sequence when coordinates are provided' do
          Vedeu::Geometry::Position[12, 19].to_s.must_equal("\e[12;19H")
        end

        it 'returns an escape sequence if a coordinate is missing' do
          Vedeu::Geometry::Position.new(12).to_s.must_equal("\e[12;1H")
        end

        it 'returns an escape sequence if the x coordinate is negative' do
          Vedeu::Geometry::Position[12, -5].to_s.must_equal("\e[12;1H")
        end

        it 'returns an escape sequence if the y coordinate is negative' do
          Vedeu::Geometry::Position[-12, 5].to_s.must_equal("\e[1;5H")
        end

        it 'resets to starting position when a block is given' do
          Vedeu::Geometry::Position[4, 9].to_s { 'test' }.must_equal("\e[4;9Htest")
        end
      end

      describe '#as_indices' do
        subject { instance.as_indices }

        it { subject.must_equal([11, 18]) }

        context 'when y is less than 1' do
          let(:y) { -3 }

          it { subject.must_equal([0, 18]) }
        end

        context 'when x is less than 1' do
          let(:x) { -9 }

          it { subject.must_equal([11, 0]) }
        end
      end

      describe '#down' do
        subject { instance.down }

        it { subject.must_be_instance_of(Vedeu::Geometry::Position) }
        it { subject.y.must_equal(13) }
        it { subject.x.must_equal(19) }

        context 'when y is 0' do
          let(:y) { 0 }

          it { subject.y.must_equal(2) }
        end
      end

      describe '#left' do
        subject { instance.left }

        it { subject.must_be_instance_of(Vedeu::Geometry::Position) }
        it { subject.y.must_equal(12) }
        it { subject.x.must_equal(18) }

        context 'when x is 0' do
          let(:x) { 0 }

          it { subject.x.must_equal(1) }
        end
      end

      describe '#right' do
        subject { instance.right }

        it { subject.must_be_instance_of(Vedeu::Geometry::Position) }
        it { subject.y.must_equal(12) }
        it { subject.x.must_equal(20) }

        context 'when x is 0' do
          let(:x) { 0 }

          it { subject.x.must_equal(2) }
        end
      end

      describe '#up' do
        subject { instance.up }

        it { subject.must_be_instance_of(Vedeu::Geometry::Position) }
        it { subject.y.must_equal(11) }
        it { subject.x.must_equal(19) }

        context 'when y is 0' do
          let(:y) { 0 }

          it { subject.y.must_equal(1) }
        end
      end

    end # Position

  end # Geometry

end # Vedeu
