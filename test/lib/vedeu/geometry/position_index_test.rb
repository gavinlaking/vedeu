require 'test_helper'

module Vedeu

  describe PositionIndex do

    let(:described) { Vedeu::PositionIndex }
    let(:instance)  { described.new(y, x) }
    let(:y)         { 6 }
    let(:x)         { 17 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@y').must_equal(5) }
      it { instance.instance_variable_get('@x').must_equal(16) }

      context 'when y is less than 1' do
        let(:y) { -3 }

        it { instance.instance_variable_get('@y').must_equal(0) }
      end

      context 'when x is less than 1' do
        let(:x) { -9 }

        it { instance.instance_variable_get('@x').must_equal(0) }
      end
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

    describe '#to_position' do
      subject { instance.to_position }

      it { subject.must_be_instance_of(Vedeu::Position) }
    end

    describe 'attr_reader' do
      context '#y' do
        subject { instance.y }

        it { subject.must_equal(5) }

        it { instance.must_respond_to(:first) }
      end

      context '#x' do
        subject { instance.x }

        it { subject.must_equal(16) }

        it { instance.must_respond_to(:last) }
      end
    end

  end # PositionIndex

end # Vedeu
