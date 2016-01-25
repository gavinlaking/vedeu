# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Style do

      let(:described) { Vedeu::Coercers::Style }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Presentation::Style }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#coerce' do
        subject { instance.coerce }

        context 'when the value is already the target class' do
          let(:_value) { klass.new }

          it { subject.must_be_instance_of(klass) }
          it { subject.must_equal(_value) }
        end

        context 'when the value is nil' do
          let(:_value) { nil }

          it { subject.must_be_instance_of(klass) }
        end

        context 'when the value is an Array' do
          let(:_value)  { [:bold, :blink] }

          it { subject.value.must_equal([:bold, :blink]) }
        end

        context 'when the value is a Hash' do
          let(:_value) {
            {
              style: [:bold, :blink]
            }
          }

          it { subject.value.must_equal([:bold, :blink]) }
        end
      end

    end # Style

  end # Coercers

end # Vedeu
