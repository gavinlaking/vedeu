require 'test_helper'

module Vedeu

  describe Char do

    let(:described)     { Vedeu::Char }
    let(:instance)      { described.new(attributes) }
    let(:attributes)    {
      {
        border:   border,
        colour:   colour,
        parent:   parent,
        position: position,
        style:    style,
        value:    value,
      }
    }
    let(:value)         { 'a' }
    let(:parent)        { Vedeu::Line.new(parent_attributes) }
    let(:parent_attributes) {
      {
        streams: [],
        parent:  nil,
        colour:  parent_colour,
        style:   parent_style,
      }
    }
    let(:border)        { nil }
    let(:colour)        { nil }
    let(:style)         { nil }
    let(:position)      { nil }
    let(:parent_colour) { nil }
    let(:parent_style)  { nil }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@border').must_equal(border) }
      it { instance.instance_variable_get('@parent').must_equal(parent) }
      it { instance.instance_variable_get('@value').must_equal(value) }

      it { instance.must_respond_to(:value) }
    end

    describe '#chars' do
      subject { instance.chars }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#eql?' do
      let(:other) { instance }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new(value: 'b') }

        it { subject.must_equal(false) }
      end
    end

    describe '#inspect' do
      let(:colour)   { Vedeu::Colour.new(foreground: '#00ff00',
                                         background: '#005500') }
      let(:position) { Vedeu::Position.new(17, 2) }
      let(:style)    { Vedeu::Style.new('underline') }


      subject { instance.inspect }

      it { subject.must_equal(
        "<Vedeu::Char '"    \
        "\\e[17;2H"         \
        "\\e[38;2;0;255;0m" \
        "\\e[48;2;0;85;0m"  \
        "\\e[4ma"           \
        "\\e[17;2H"         \
        "'>"
      ) }
    end

    describe '#to_hash' do
      subject { instance.to_hash }

      it { subject.must_be_instance_of(Hash) }

      it { subject.must_equal(
                  border: '',
                  colour: {
            background: '',
            foreground: '',
          },
                  parent: {
            background: '',
            foreground: '',
            style: '',
          },
                  position: {
            y: nil,
            x: nil
          },
                  style: '',
                  value: 'a',
      ) }
    end

    describe '#to_html' do
      subject { instance.to_html }

      it { subject.must_be_instance_of(String) }
    end

    describe '#to_json' do
      subject { instance.to_json }

      it { subject.must_be_instance_of(String) }
    end

    describe '#to_s' do
      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

      context 'when a position is specified' do
        let(:position) { Vedeu::Position.new(17, 2) }

        it { subject.must_equal("\e[17;2Ha\e[17;2H") }
      end

      context 'when a position is not specified' do
        let(:position) {}

        it { subject.must_equal('a') }
      end

      context 'when a colour is specified' do
        let(:colour) { Vedeu::Colour.new(foreground: '#00ff00',
                                         background: '#005500') }

        context 'and a parent colour is specified' do
          let(:parent_colour) { Vedeu::Colour.new(foreground: '#ff0000',
                                                  background: '#550000') }

          it { subject.must_equal("\e[38;2;0;255;0m\e[48;2;0;85;0ma") }
        end

        context 'and a parent colour is not specified' do
          let(:parent_colour) {}

          it { subject.must_equal("\e[38;2;0;255;0m\e[48;2;0;85;0ma") }
        end
      end

      context 'when a colour is not specified' do
        let(:colour) {}

        it { subject.must_equal('a') }
      end

      context 'when a style is specified' do
        let(:style) { Vedeu::Style.new('underline') }

        context 'when a parent style is specified' do
          let(:parent_style) { Vedeu::Style.new('bold') }

          it { subject.must_equal("\e[4ma") }
        end

        context 'when a parent style is not specified' do
          let(:parent_style) {}

          it { subject.must_equal("\e[4ma") }
        end
      end

      context 'when a style is not specified' do
        let(:style) {}

        it { subject.must_equal('a') }
      end

      context 'when the value is nil' do
        let(:value) {}

        it { subject.must_equal('') }
      end
    end

    describe '#value' do
      subject { instance.value }

      it { subject.must_be_instance_of(String) }

      context 'when the border attribute is defined' do
        let(:border) { :top_left }
        let(:value)  { "\x6C" }

        it { subject.must_equal("\e(0l\e(B") }
      end

      context 'when the border attributes is not defined' do
        it { subject.must_equal('a') }
      end
    end

    describe '#x' do
      let(:position) { Vedeu::Position.new(17, 2) }

      subject { instance.x }

      context 'when a position is set' do
        it { subject.must_equal(2) }
      end

      context 'when a position is not set' do
        let(:position) {}

        it { subject.must_equal(nil) }
      end
    end

    describe '#y' do
      let(:position) { Vedeu::Position.new(17, 2) }

      subject { instance.y }

      context 'when a position is set' do
        it { subject.must_equal(17) }
      end

      context 'when a position is not set' do
        let(:position) {}

        it { subject.must_equal(nil) }
      end
    end

  end # Char

end # Vedeu
