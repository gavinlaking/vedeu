require 'test_helper'

module Vedeu

  describe PositionIndex do

    let(:described) { Vedeu::PositionIndex }
    let(:instance)  { described.new(y, x) }
    let(:y)         { 6 }
    let(:x)         { 17 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@y').must_equal(y) }
      it { instance.instance_variable_get('@x').must_equal(x) }
    end

    describe '.[]' do
      subject { described[y, x] }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([5, 16]) }
    end

    describe '#[]' do
      subject { instance.[] }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([5, 16]) }
    end

    describe '#eql?' do
      let(:other) { described.new(6, 17) }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new(2, 9) }

        it { subject.must_equal(false) }
      end
    end

    describe '#to_position' do
      subject { instance.to_position }

      it { subject.must_be_instance_of(Vedeu::Position) }
    end

    describe '#y' do
      subject { instance.y }

      it { subject.must_equal(5) }

      it { instance.must_respond_to(:first) }

      context 'when y is less than 1' do
        let(:y) { -3 }

        it { subject.must_equal(0) }
      end
    end

    describe '#x' do
      subject { instance.x }

      it { subject.must_equal(16) }

      it { instance.must_respond_to(:last) }

      context 'when x is less than 1' do
        let(:x) { -9 }

        it { subject.must_equal(0) }
      end
    end

  end # PositionIndex

end # Vedeu
