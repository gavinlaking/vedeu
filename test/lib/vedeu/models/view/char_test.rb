require 'test_helper'

module Vedeu

  describe Char do

    let(:described)     { Vedeu::Char }
    let(:instance)      { described.new(value, parent, colour, style, position) }
    let(:value)         { 'a' }
    let(:parent)        { Line.new([], nil, parent_colour, parent_style) }
    let(:colour)        { nil }
    let(:style)         { nil }
    let(:position)      { nil }
    let(:parent_colour) { nil }
    let(:parent_style)  { nil }

    describe '.coerce' do
      subject { described.coerce(value, parent, colour, style, position) }

      context 'when the value is already a Char' do
        let(:value) { described.new('b') }

        it { return_value_for(subject, value) }
      end

      context 'when the value is an Array' do
        context 'and the Array contains instances of Char' do
          let(:value) { [described.new('b')] }

          it { return_value_for(subject, value) }
        end

        context 'and the Array contains instances of String' do
          let(:value) { ['carbon'] }

          it { return_type_for(subject, Array) }
        end

        context 'and the Array contains instances of NilClass' do
          let(:value) { [] }

          it { return_type_for(subject, NilClass) }
        end
      end

      context 'when the value is not a Char or Array' do
        let(:value) { {} }

        it { return_type_for(subject, NilClass) }
      end
    end

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Char) }
      it { assigns(subject, '@colour', colour) }
      it { assigns(subject, '@parent', parent) }
      it { assigns(subject, '@style', style) }
      it { assigns(subject, '@value', value) }
      it { assigns(subject, '@position', position) }
    end

    describe '#value' do
      subject { instance.value }

      context 'when the value is not set' do
        let(:value) {}

        it { return_value_for(subject, '') }
      end

      context 'when the value is set' do
        it { return_value_for(subject, 'a') }

        context 'and the value is more than one character' do
          let(:value) { 'multi' }

          it { return_value_for(subject, 'm') }
        end
      end
    end

    describe '#to_s' do
      subject { instance.to_s }

      it { return_type_for(subject, String) }

      context 'when a position is specified' do
        let(:position) { Position.new(17, 2) }

        it { return_value_for(subject, "\e[17;2Ha\e[17;2H") }
      end

      context 'when a position is not specified' do
        let(:position) {}

        it { return_value_for(subject, "a") }
      end

      context 'when a colour is specified' do
        let(:colour) { Colour.new({ foreground: '#00ff00', background: '#005500' }) }

        context 'when a parent colour is specified' do
          let(:parent_colour) { Colour.new({ foreground: '#ff0000', background: '#550000' }) }

          it { return_value_for(subject, "\e[38;2;0;255;0m\e[48;2;0;85;0ma\e[38;2;255;0;0m\e[48;2;85;0;0m") }
        end

        context 'when a parent colour is not specified' do
          let(:parent_colour) {}

          it { return_value_for(subject, "\e[38;2;0;255;0m\e[48;2;0;85;0ma") }
        end
      end

      context 'when a colour is not specified' do
        let(:colour) {}

        it { return_value_for(subject, "a") }
      end

      context 'when a style is specified' do
        let(:style) { Style.new('underline') }

        context 'when a parent style is specified' do
          let(:parent_style) { Style.new('bold') }

          it { return_value_for(subject, "\e[4ma\e[1m") }
        end

        context 'when a parent style is not specified' do
          let(:parent_style) {}

          it { return_value_for(subject, "\e[4ma") }
        end
      end

      context 'when a style is not specified' do
        let(:style) {}

        it { return_value_for(subject, "a") }
      end

      context 'when the value is nil' do
        let(:value) {}

        it { return_value_for(subject, "") }
      end

      context 'when the value is more than one character' do
        let(:value) { 'multi' }

        it { return_value_for(subject, "m") }
      end
    end

  end # Char

end # Vedeu
