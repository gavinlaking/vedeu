# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Presentation

    describe Style do

      let(:described) { Vedeu::Presentation::Style }
      let(:instance)  { described.new(_value) }
      let(:_value)    { 'bold' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal('bold') }
      end

      describe '#escape_sequences' do
        it { instance.must_respond_to(:escape_sequences) }
      end

      describe '#value' do
        it { instance.must_respond_to(:value) }
      end

      describe '#value=' do
        it { instance.must_respond_to(:value=) }
      end

      describe '.coerce' do
        let(:_value) { 'bold' }

        subject { described.coerce(_value) }

        it { subject.must_be_instance_of(described) }

        context 'when the value is nil' do
          let(:_value) { nil }

          it { subject.must_be_instance_of(described) }
        end

        context 'when the value is a Style already' do
          let(:_value) { Vedeu::Presentation::Style.new('bold') }

          it 'returns the value' do
            subject.must_equal(_value)
          end
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

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }

        it 'returns an attributes hash for this instance' do
          subject.must_equal(style: 'bold')
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new('underline') }

          it { subject.must_equal(false) }
        end
      end

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#to_s' do
        let(:_value) {}

        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }

        context 'for a single style' do
          let(:_value) { 'normal' }

          it 'returns an escape sequence' do
            subject.must_equal("\e[24m\e[22m\e[27m")
          end
        end

        context 'for multiple styles' do
          let(:_value) { ['normal', 'underline'] }

          it 'returns an escape sequence for multiple styles' do
            subject.must_equal("\e[24m\e[22m\e[27m\e[4m")
          end
        end

        context 'for an unknown style' do
          let(:_value) { 'unknown' }

          it 'returns an empty string for an unknown style' do
            subject.must_equal('')
          end
        end

        context 'for an empty or nil' do
          let(:_value) { '' }

          it 'returns an empty string for empty or nil' do
            subject.must_equal('')
          end
        end
      end

    end # Style

  end # Presentation

end # Vedeu
