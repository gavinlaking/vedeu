# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe Empty do

      let(:described)  { Vedeu::Cells::Empty }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          colour:   colour,
          name:     _name,
          position: position,
          style:    style,
          value:    _value,
        }
      }
      let(:colour)   { {} }
      let(:_name)    { nil }
      let(:position) { Vedeu::Geometries::Position.new(1, 1) }
      let(:style)    { '' }
      let(:_value)   { '' }

      describe '#as_html' do
        subject { instance.as_html }

        it { subject.must_equal('&nbsp;') }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#value' do
        it { instance.must_respond_to(:value) }
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) {
            described.new(position: Vedeu::Geometries::Position.new(1, 2))
          }

          it { subject.must_equal(false) }
        end
      end

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#text' do
        subject { instance.text }

        it { subject.must_equal(' ') }
      end

      describe '#to_h' do
        let(:colour)   { Vedeu::Colours::Colour.new(background: '#000000') }
        let(:expected) {
          {
            name:     '',
            style:    '',
            type:     :empty,
            value:    '',
            colour:   {
              background: '#000000',
              foreground: '',
            },
            position: {
              y: 1,
              x: 1,
            },
          }
        }

        subject { instance.to_h }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

      describe '#to_hash' do
        it { instance.must_respond_to(:to_hash) }
      end

      describe '#to_html' do
        subject { instance.to_html }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('<td>&nbsp;</td>') }
      end

      describe '#to_s' do
        let(:position) {}
        let(:_value)   { 'a' }

        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }

        context 'when a position is specified' do
          let(:position) { Vedeu::Geometries::Position.coerce([17, 2]) }

          it { subject.must_equal("\e[17;2Ha") }
        end

        context 'when a position is not specified' do
          let(:position) {}

          it { subject.must_equal('a') }
        end

        context 'when a colour is specified' do
          let(:colour) {
            Vedeu::Colours::Colour.new(foreground: '#00ff00',
                                       background: '#005500')
          }

          context 'and a parent colour is specified' do
            let(:parent_colour) {
              Vedeu::Colours::Colour.new(foreground: '#ff0000',
                                         background: '#550000')
            }

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
          let(:style) { Vedeu::Presentation::Style.new('underline') }

          context 'when a parent style is specified' do
            let(:parent_style) { Vedeu::Presentation::Style.new('bold') }

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
          let(:_value) {}

          it { subject.must_equal('') }
        end
      end

      describe '#to_str' do
        it { instance.must_respond_to(:to_str) }
      end

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:empty) }
      end

    end # Empty

  end # Cells

end # Vedeu
