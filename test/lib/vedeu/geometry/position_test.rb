require 'test_helper'

module Vedeu

  describe Position do

    let(:described) { Vedeu::Position }
    let(:instance)  { described.new(y, x) }
    let(:y)         { 12 }
    let(:x)         { 19 }

    describe 'alias methods' do
      it { instance.must_respond_to(:first) }
      it { instance.must_respond_to(:last) }
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@y').must_equal(y) }
      it { instance.instance_variable_get('@x').must_equal(x) }
    end

    describe '.coerce' do
      let(:value) {}

      subject { described.coerce(value) }

      context 'when the value is already a Position' do
        let(:value) { instance }

        it { subject.must_equal(instance) }
      end

      context 'when the value is an Array' do
        let(:value) { [2, 8] }

        it { subject.must_be_instance_of(described) }
        it { subject.y.must_equal(2) }
        it { subject.x.must_equal(8) }
      end

      context 'when the value is a Hash' do
        let(:value) { { y: 3, x: 9 } }

        it { subject.must_be_instance_of(described) }
        it { subject.y.must_equal(3) }
        it { subject.x.must_equal(9) }
      end

      context 'when the value is something unhandled' do
        it { subject.must_be_instance_of(NilClass) }
      end
    end

    describe '#==' do
      let(:other) {}

      subject { instance == other }

      context 'when they are equal' do
        let(:other) { described.new(12, 19) }

        it { subject.must_equal(true) }
      end

      context 'when they are not equal' do
        let(:other) { described.new(2, 9) }

        it { subject.must_equal(false) }
      end
    end

    describe '#to_s' do
      # subject { described.new.to_s }

      it 'returns an escape sequence when no coordinates are provided' do
        Position.new.to_s.must_equal("\e[1;1H")
      end

      it 'returns an escape sequence when coordinates are provided' do
        Position.new(12, 19).to_s.must_equal("\e[12;19H")
      end

      it 'returns an escape sequence if a coordinate is missing' do
        Position.new(12).to_s.must_equal("\e[12;1H")
      end

      it 'returns an escape sequence if the x coordinate is negative' do
        Position.new(12, -5).to_s.must_equal("\e[12;1H")
      end

      it 'returns an escape sequence if the y coordinate is negative' do
        Position.new(-12, 5).to_s.must_equal("\e[1;5H")
      end

      it 'resets to starting position when a block is given' do
        Position.new(4, 9).to_s { 'test' }.must_equal("\e[4;9Htest\e[4;9H")
      end
    end

  end # Position

end # Vedeu
