require 'test_helper'

module Vedeu

  describe Direct do

    let(:described) { Vedeu::Direct }
    let(:instance)  { described.new(value: _value, x: x, y: y) }
    let(:_value)    {}
    let(:x)         {}
    let(:y)         {}

    before { Vedeu::Terminal.stubs(:output) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }

      context 'when no value is given' do
        it { instance.instance_variable_get('@value').must_equal('') }
      end

      context 'when a value is given' do
        let(:_value) { 'some value' }

        it { instance.instance_variable_get('@value').must_equal('some value') }
      end

      context 'when no x is given' do
        it { instance.instance_variable_get('@x').must_equal(1) }
      end

      context 'when an x is given' do
        let(:x) { 6 }
        it { instance.instance_variable_get('@x').must_equal(6) }
      end

      context 'when no y is given' do
        it { instance.instance_variable_get('@y').must_equal(1) }
      end

      context 'when a y is given' do
        let(:y) { 3 }

        it { instance.instance_variable_get('@y').must_equal(3) }
      end
    end

    describe '.write' do
      subject { described.write(value: _value, x: x, y: y) }

      it { subject.must_be_instance_of(String) }

      context 'when a value is given' do
        let(:_value) { 'some value' }

        it { subject.must_equal("\e[1;1Hsome value") }
      end

      context 'when a value is not given' do
        it { subject.must_equal("\e[1;1H") }
      end
    end

    describe '#write' do
      it { instance.must_respond_to(:write) }
    end

  end # Direct

end # Vedeu
