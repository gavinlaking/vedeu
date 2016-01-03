# frozen_string_literal: true

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

      describe '#named?' do
        subject { instance.named? }

        context 'when the value is a valid name' do
          let(:_value) { :blue }

          it { subject.must_equal(true) }
        end

        context 'when the value is an invalid name' do
          let(:_value) { :invalid }

          it { subject.must_equal(false) }
        end
      end

      describe '#numbered?' do
        subject { instance.numbered? }

        context 'when the value is a valid number' do
          let(:_value) { 136 }

          it { subject.must_equal(true) }
        end

        context 'when the value is an invalid number' do
          let(:_value) { -1 }

          it { subject.must_equal(false) }
        end

        context 'when the value is an invalid number' do
          let(:_value) { 256 }

          it { subject.must_equal(false) }
        end
      end

      describe '#rgb?' do
        subject { instance.rgb? }

        context 'when the value is a HTML/CSS formatted hexadecimal string' do
          let(:_value) { '#654321' }

          it { subject.must_equal(true) }
        end

        context 'but the value is an invalid HTML/CSS formatted hexadecimal' do
          let(:_value) { '#123' }

          it { subject.must_equal(false) }
        end
      end

      describe '.valid?' do
        subject { described.valid?(_value) }

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

        context 'when the value is a HTML/CSS formatted hexidecimal string' do
          let(:_value) { '#654321' }

          it { subject.must_equal(true) }

          context 'but the value is invalid' do
            let(:_value) { '#123' }

            it { subject.must_equal(false) }
          end
        end

        context 'when the value is a named symbol' do
          let(:_value) { :red }

          it { subject.must_equal(true) }

          context 'but the value is invalid' do
            let(:_value) { :invalid }

            it { subject.must_equal(false) }
          end
        end

        context 'when the value is a number' do
          let(:_value) { 38 }

          it { subject.must_equal(true) }

          context 'but the value is invalid' do
            let(:_value) { 280 }

            it { subject.must_equal(false) }
          end
        end
      end

      describe '#valid?' do
        it { instance.must_respond_to(:valid?) }
      end

    end # Validator

  end # Colours

end # Vedeu
