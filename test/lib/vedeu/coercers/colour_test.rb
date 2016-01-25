# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Colour do

      let(:described) { Vedeu::Coercers::Colour }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Colours::Colour }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        subject { described.coerce(_value) }

        context 'when the value is nil' do
          it { subject.must_be_instance_of(klass) }
        end

        context 'when the value is a Hash' do
          let(:_value) {
            {
              background: '#ff0000',
              foreground: '#00ff00',
            }
          }

          it { subject.must_be_instance_of(klass) }
          it do
            subject.background.must_be_instance_of(Vedeu::Colours::Background)
          end
          it do
            subject.foreground.must_be_instance_of(Vedeu::Colours::Foreground)
          end
        end

        context 'when the value is a Vedeu::Colours::Background' do
          let(:_value)   { Vedeu::Colours::Background.new('#aadd00') }

          it { subject.must_be_instance_of(klass) }
        end

        context 'when the value is already the target class' do
          let(:_value) { klass.new }

          it { subject.must_be_instance_of(klass) }
          it { subject.must_equal(_value) }
        end

        context 'when the value is a Vedeu::Colours::Foreground' do
          let(:_value) { Vedeu::Colours::Foreground.new('#448822') }

          it { subject.must_be_instance_of(klass) }
        end

        context 'when the value is invalid or unsupported' do
          let(:_value) { :invalid }

          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

      describe '#coerce' do
        it { instance.must_respond_to(:coerce) }
      end

    end # Colour

  end # Coercers

end # Vedeu
