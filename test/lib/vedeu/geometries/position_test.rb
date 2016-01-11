# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Geometries

    describe Position do

      let(:described) { Vedeu::Geometries::Position }
      let(:instance)  { described.new(y, x) }
      let(:y)         { 12 }
      let(:x)         { 19 }

      let(:term_height) { 15 }
      let(:term_width)  { 20 }

      before do
        Vedeu.stubs(:height).returns(term_height)
        Vedeu.stubs(:width).returns(term_width)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when y < 1' do
          let(:y) { -3 }

          it { instance.instance_variable_get('@y').must_equal(1) }
        end

        context 'when y > Vedeu.height' do
          let(:y) { 17 }

          it { instance.instance_variable_get('@y').must_equal(term_height) }
        end

        context 'when y >= 1 and y <= Vedeu.height' do
          it { instance.instance_variable_get('@y').must_equal(y) }
        end

        context 'when x < 1' do
          let(:x) { -2 }

          it { instance.instance_variable_get('@x').must_equal(1) }
        end

        context 'when x > Vedeu.width' do
          let(:x) { 23 }

          it { instance.instance_variable_get('@x').must_equal(term_width) }
        end

        context 'when x >= 1 and x <= Vedeu.height' do
          it { instance.instance_variable_get('@x').must_equal(x) }
        end
      end

      describe '.[]' do
        subject { described.[](y, x) }

        it { instance.must_be_instance_of(described) }

        context 'when the x and y coordinates are given' do
          it { instance.y.must_equal(12) }
          it { instance.x.must_equal(19) }
        end

        context 'when the x coordinate is not given' do
          let(:x) {}

          it { instance.y.must_equal(12) }
          it { instance.x.must_equal(1) }
        end

        context 'when the y coordinate is not given' do
          let(:y) {}

          it { instance.y.must_equal(1) }
          it { instance.x.must_equal(19) }
        end

        context 'when the x and y coordinates are not given' do
          let(:x) {}
          let(:y) {}

          it { instance.y.must_equal(1) }
          it { instance.x.must_equal(1) }
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

        context 'when the value is an Fixnum' do
          let(:_value) { 2 }

          it { subject.must_be_instance_of(described) }
          it { subject.y.must_equal(2) }
          it { subject.x.must_equal(1) }
        end

        context 'when the value is a Hash' do
          let(:_value) { { y: 3, x: 9 } }

          it { subject.must_be_instance_of(described) }
          it { subject.y.must_equal(3) }
          it { subject.x.must_equal(9) }
        end

        context 'when the value is a NilClass' do
          let(:_value) {}

          it { subject.must_be_instance_of(NilClass) }
        end

        context 'when the value is something unhandled' do
          let(:_value) { :invalid }

          it { subject.must_be_instance_of(NilClass) }
        end
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

      describe '#eql?' do
        let(:other) { described.new(12, 19) }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(2, 9) }

          it { subject.must_equal(false) }
        end
      end

      describe '#first' do
        it { instance.must_respond_to(:first) }
      end

      describe '#last' do
        it { instance.must_respond_to(:last) }
      end

      describe '#to_a' do
        subject { instance.to_a }

        it { subject.must_equal([12, 19]) }
      end

      describe '#to_h' do
        let(:expected) {
          {
            position: {
              y: 12,
              x: 19,
            }
          }
        }

        subject { instance.to_h }

        it { subject.must_equal(expected) }
      end

      describe '#to_hash' do
        it { instance.must_respond_to(:to_h) }
      end

      describe '#to_s' do
        let(:_value) {}

        subject { described.coerce(_value).to_s }

        context 'when no coordinates are provided' do
          it { subject.must_equal('') }
        end

        context 'when coordinates are provided' do
          let(:_value) { [12, 19] }

          it 'returns an escape sequence' do
            subject.must_equal("\e[12;19H")
          end
        end

        context 'when a coordinate is missing' do
          let(:_value) { 12 }

          it 'returns an escape sequence' do
            subject.must_equal("\e[12;1H")
          end
        end

        context 'when the x coordinate is negative' do
          let(:_value) { [12, -5] }

          it 'returns an escape sequence' do
            subject.must_equal("\e[12;1H")
          end
        end

        context 'when the y coordinate is negative' do
          let(:_value) { [-12, 5] }

          it 'returns an escape sequence' do
            subject.must_equal("\e[1;5H")
          end
        end

        context 'when a block is given' do
          let(:instance) { described.coerce(_value) }
          let(:_value)   { [4, 9] }

          subject { instance.to_s { 'test' } }

          it 'returns an escape sequence and the result of the block' do
            subject.must_equal("\e[4;9Htest")
          end
        end
      end

      describe '#x' do
        it { instance.must_respond_to(:x) }
      end

      describe '#y' do
        it { instance.must_respond_to(:y) }
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

        context 'when moving down is inside the terminal boundary' do
          it { subject.must_be_instance_of(described) }
          it { subject.wont_equal(instance) }
          it { subject.y.must_equal(13) }
        end

        context 'when moving down is not inside the terminal boundary' do
          let(:y) { 15 }

          it { subject.must_equal(instance) }
          it { subject.y.must_equal(15) }
        end
      end

      describe '#left' do
        subject { instance.left }

        context 'when moving left is inside the terminal boundary' do
          it { subject.must_be_instance_of(described) }
          it { subject.wont_equal(instance) }
          it { subject.x.must_equal(18) }
        end

        context 'when moving left is not inside the terminal boundary' do
          let(:x) { 1 }

          it { subject.must_equal(instance) }
          it { subject.x.must_equal(1) }
        end
      end

      describe '#right' do
        subject { instance.right }

        it { subject.x.must_equal(20) }

        context 'when moving right is inside the terminal boundary' do
          it { subject.must_be_instance_of(described) }
          it { subject.wont_equal(instance) }
          it { subject.x.must_equal(20) }
        end

        context 'when moving right is not inside the terminal boundary' do
          let(:x) { 20 }

          it { subject.must_equal(instance) }
          it { subject.x.must_equal(20) }
        end
      end

      describe '#up' do
        subject { instance.up }

        context 'when moving up is inside the terminal boundary' do
          it { subject.must_be_instance_of(described) }
          it { subject.wont_equal(instance) }
          it { subject.y.must_equal(11) }
        end

        context 'when moving up is not inside the terminal boundary' do
          let(:y) { 1 }

          it { subject.must_equal(instance) }
          it { subject.y.must_equal(1) }
        end
      end

    end # Position

  end # Geometries

end # Vedeu
