# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe Point do

    let(:described) { Vedeu::Point }
    let(:instance)  { described.new(value: _value, min: min, max: max) }
    let(:_value)    { 5 }
    let(:min)       { 2 }
    let(:max)       { 9 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@min').must_equal(min) }
      it { instance.instance_variable_get('@max').must_equal(max) }
      it { instance.instance_variable_get('@value').must_equal(_value) }
    end

    describe '.coerce' do
      subject { described.coerce(value: _value, min: min, max: max) }

      context 'when :min is not a Integer' do
        let(:min) { :invalid }

        it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
      end

      context 'when :min is not given' do
        subject { described.coerce(value: _value, max: max) }

        it { subject.must_be_instance_of(Vedeu::Point) }
      end

      context 'when :max is not given' do
        subject { described.coerce(value: _value, min: min) }

        it { subject.must_be_instance_of(Vedeu::Point) }
      end

      context 'when :max is not a Integer or Float::INFINITY' do
        let(:max) { :invalid }

        it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
      end

      context 'when :max is a Float::INFINITY' do
        let(:max) { Float::INFINITY }

        it { subject.must_be_instance_of(Vedeu::Point) }
      end

      context 'when :min > :max' do
        let(:max) { 4 }
        let(:min) { 7 }

        it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
      end

      context 'when :value is nil' do
        let(:_value) {}

        it {
          subject.must_be_instance_of(Vedeu::Point)
          subject.value.must_equal(min)
        }
      end

      context 'when :value is not nil' do
        context 'when :value is less than min' do
          let(:_value) { 1 }

          it {
            subject.must_be_instance_of(Vedeu::Point)
            subject.value.must_equal(min)
          }
        end

        context 'when :value is greater than max' do
          let(:_value) { 11 }

          it {
            subject.must_be_instance_of(Vedeu::Point)
            subject.value.must_equal(max)
          }
        end

        context 'when :value > :min and :value < :max' do
          it {
            subject.must_be_instance_of(Vedeu::Point)
            subject.value.must_equal(_value)
          }
        end
      end
    end

    describe '.valid?' do
      subject { described.valid?(value: _value, min: min, max: max) }

      context 'when the value is not a Integer' do
        let(:_value) { :invalid }

        it { subject.must_equal(false) }
      end

      context 'when the value is a Integer' do
        context 'but the value < min' do
          let(:_value) { 1 }

          it { subject.must_equal(false) }
        end

        context 'but the value >= min' do
          let(:_value) { 5 }

          it { subject.must_equal(true) }
        end

        context 'but the value > max' do
          let(:_value) { 11 }

          it { subject.must_equal(false) }
        end

        context 'but the value <= max' do
          let(:_value) { 7 }

          it { subject.must_equal(true) }
        end
      end
    end

    describe '#coerce' do
      it { instance.must_respond_to(:coerce) }
    end

    describe '#valid?' do
      it { instance.must_respond_to(:valid?) }
    end

    describe '#value' do
      subject { instance.value }

      context 'when :value is nil' do
        let(:_value) {}

        it { subject.must_equal(min) }
      end

      context 'when :value is not nil' do
        it { subject.must_equal(_value) }
      end
    end

  end # Point

end # Vedeu
