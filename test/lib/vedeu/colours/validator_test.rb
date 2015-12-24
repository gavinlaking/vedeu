require 'test_helper'

module Vedeu

  module Colours

    describe Validator do

      let(:described) { Vedeu::Colours::Validator }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.valid?' do
        subject { described.valid?(_value) }

        context 'when the value is a HTML/CSS formatted hexidecimal string' do
          let(:_value) { '#654321' }

          it { subject.must_equal(true) }
        end

        context 'when the value is a Vedeu::Colours::Background' do
          let(:_value) { Vedeu::Colours::Background.new('#654321') }

          it { subject.must_equal(true) }
        end

        context 'when the value is a Vedeu::Colours::Colour' do
          let(:_value) { Vedeu::Colours::Colour.new }

          it { subject.must_equal(true) }
        end

        context 'when the value is a Vedeu::Colours::Foreground' do
          let(:_value) { Vedeu::Colours::Foreground.new('#654321') }

          it { subject.must_equal(true) }
        end

        context 'when the value is invalid' do
          let(:_value) { '#123' }

          it { subject.must_equal(false) }
        end
      end

      describe '#valid?' do
        it { instance.must_respond_to(:valid?) }
      end

    end # Validator

  end # Colours

end # Vedeu
