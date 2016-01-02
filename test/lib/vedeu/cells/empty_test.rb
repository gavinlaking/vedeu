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
      let(:_name)    { '' }
      let(:position) {}
      let(:style)    { '' }
      let(:_value)   { '' }

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#value' do
        it { instance.must_respond_to(:value) }
      end

      describe '#cell?' do
        subject { instance.cell? }

        it { subject.must_equal(true) }
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

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#text' do
        subject { instance.text }

        it { subject.must_equal(' ') }
      end

      describe '#to_hash' do
        let(:position) { [1, 1] }
        let(:colour)   { Vedeu::Colours::Colour.new(background: '#000000') }
        let(:expected) {
          {
            colour:   "\e[48;2;0;0;0m",
            style:    '',
            value:    '',
            position: "\e[1;1H",
          }
        }

        subject { instance.to_hash }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

      describe '#to_html' do
        subject { instance.to_html }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
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
