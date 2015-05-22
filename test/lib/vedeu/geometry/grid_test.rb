require 'test_helper'

module Vedeu

  describe Grid do

    let(:described) { Vedeu::Grid }
    let(:instance)  { described.new(_value) }
    let(:_value)    { 2 }

    before { IO.console.stubs(:winsize).returns([25, 80]) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@value').must_equal(_value) }
    end

    describe '.columns' do
      context 'when the value is less than 1' do
        it { proc { Grid.columns(0) }.must_raise(OutOfRange) }
      end

      context 'when the value is greater than 12' do
        it { proc { Grid.columns(13) }.must_raise(OutOfRange) }
      end

      context 'when the value is in range' do
        it 'returns the value of the column' do
          Grid.columns(7).must_equal(42)
        end
      end
    end

    describe '#height' do
      subject { instance.height }

      it { subject.must_equal(2) }
    end

    describe '.rows' do
      context 'when the value is less than 1' do
        it { proc { Grid.rows(0) }.must_raise(OutOfRange) }
      end

      context 'when the value is greater than 12' do
        it { proc { Grid.rows(13) }.must_raise(OutOfRange) }
      end

      context 'when the value is in range' do
        it 'returns the value of the row' do
          Grid.rows(7).must_equal(14)
        end
      end
    end

    describe '#width' do
      subject { instance.width }

      it { subject.must_equal(6) }
    end

  end # Grid

end # Vedeu
