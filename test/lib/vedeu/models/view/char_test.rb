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

    describe '.build' do
      subject {
        described.build({}) do
          # ...
        end
      }

      it { skip }
    end

    describe '.coerce' do
      subject { described.coerce(value, parent, colour, style, position) }

      context 'when the value is already a Char' do
        let(:value) { described.new('b') }

        it { subject.must_equal(value) }
      end

      context 'when the value is an Array' do
        context 'and the Array contains instances of Char' do
          let(:value) { [described.new('b')] }

          it { subject.must_equal(value) }
        end

        context 'and the Array contains instances of String' do
          let(:value) { ['carbon'] }

          it { subject.must_be_instance_of(Array) }
        end

        context 'and the Array contains instances of NilClass' do
          let(:value) { [] }

          it { subject.must_be_instance_of(NilClass) }
        end
      end

      context 'when the value is not a Char or Array' do
        let(:value) { {} }

        it { subject.must_be_instance_of(NilClass) }
      end
    end

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Char) }
      it { subject.instance_variable_get('@colour').must_equal(colour) }
      it { subject.instance_variable_get('@parent').must_equal(parent) }
      it { subject.instance_variable_get('@style').must_equal(style) }
      it { subject.instance_variable_get('@value').must_equal(value) }
      it { subject.instance_variable_get('@position').must_equal(position) }
    end

    describe '#value' do
      subject { instance.value }

      context 'when the value is not set' do
        let(:value) {}

        it { subject.must_equal('') }
      end

      context 'when the value is set' do
        it { subject.must_equal('a') }

        context 'and the value is more than one character' do
          let(:value) { 'multi' }

          it { subject.must_equal('m') }
        end
      end
    end

    describe '#to_s' do
      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

      context 'when a position is specified' do
        let(:position) { Position.new(17, 2) }

        it { subject.must_equal("\e[17;2Ha\e[17;2H") }
      end

      context 'when a position is not specified' do
        let(:position) {}

        it { subject.must_equal("a") }
      end

      context 'when a colour is specified' do
        let(:colour) { Colour.new({ foreground: '#00ff00', background: '#005500' }) }

        context 'when a parent colour is specified' do
          let(:parent_colour) { Colour.new({ foreground: '#ff0000', background: '#550000' }) }

          it { subject.must_equal("\e[38;2;0;255;0m\e[48;2;0;85;0ma\e[38;2;255;0;0m\e[48;2;85;0;0m") }
        end

        context 'when a parent colour is not specified' do
          let(:parent_colour) {}

          it { subject.must_equal("\e[38;2;0;255;0m\e[48;2;0;85;0ma") }
        end
      end

      context 'when a colour is not specified' do
        let(:colour) {}

        it { subject.must_equal("a") }
      end

      context 'when a style is specified' do
        let(:style) { Style.new('underline') }

        context 'when a parent style is specified' do
          let(:parent_style) { Style.new('bold') }

          it { subject.must_equal("\e[4ma\e[1m") }
        end

        context 'when a parent style is not specified' do
          let(:parent_style) {}

          it { subject.must_equal("\e[4ma") }
        end
      end

      context 'when a style is not specified' do
        let(:style) {}

        it { subject.must_equal("a") }
      end

      context 'when the value is nil' do
        let(:value) {}

        it { subject.must_equal("") }
      end

      context 'when the value is more than one character' do
        let(:value) { 'multi' }

        it { subject.must_equal("m") }
      end
    end

  end # Char

end # Vedeu
