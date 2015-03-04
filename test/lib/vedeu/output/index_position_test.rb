require 'test_helper'

module Vedeu

  describe IndexPosition do

    let(:described) { Vedeu::IndexPosition }
    let(:instance)  { described.new(y, x) }
    let(:y)         { 6 }
    let(:x)         { 17 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@y').must_equal(7) }
      it { instance.instance_variable_get('@x').must_equal(18) }

      context 'when y is less than 0' do
        let(:y) { -3 }

        it { instance.instance_variable_get('@y').must_equal(1) }
      end

      context 'when x is less than 0' do
        let(:x) { -9 }

        it { instance.instance_variable_get('@x').must_equal(1) }
      end
    end

    describe '.[]' do
      subject { described[y, x] }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([7, 18]) }
    end

    describe '#[]' do
      subject { instance.[] }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([7, 18]) }
    end

    describe 'attr_reader' do
      context '#y' do
        subject { instance.y }

        it { subject.must_equal(7) }

        it { instance.must_respond_to(:first) }
      end

      context '#x' do
        subject { instance.x }

        it { subject.must_equal(18) }

        it { instance.must_respond_to(:last) }
      end
    end

  end # IndexPosition

end # Vedeu
