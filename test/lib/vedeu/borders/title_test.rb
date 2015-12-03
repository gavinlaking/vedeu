require 'test_helper'

module Vedeu

  module Borders

    describe Title do

      let(:described)  { Vedeu::Borders::Title }
      let(:instance)   { described.new(_name, _value, horizontal) }
      let(:_name)      { 'Vedeu::Borders::Title' }
      let(:_value)     { 'Aluminium' }
      let(:horizontal) {
        [
          Vedeu::Views::Char.new(value: '-', position: [1, 1], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 2], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 3], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 4], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 5], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 6], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 7], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 8], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 9], border: type),
          Vedeu::Views::Char.new(value: '-', position: [1, 10], border: type),
        ]
      }
      let(:type) { :top_horizontal }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@horizontal').must_equal(horizontal) }
      end

      describe '.render' do
        subject { described.render(_name, _value, horizontal) }

        context 'when the title is empty' do
          let(:_value) {}

          it { subject.must_equal(horizontal) }
        end

        context 'when the title is not empty' do
          let(:expected) {
            [
              Vedeu::Views::Char.new(value: '-', position: [1, 1], border: type),
              Vedeu::Cells::Char.new(value: ' ', position: [1, 2]),
              Vedeu::Cells::Char.new(value: 'A', position: [1, 3]),
              Vedeu::Cells::Char.new(value: 'l', position: [1, 4]),
              Vedeu::Cells::Char.new(value: 'u', position: [1, 5]),
              Vedeu::Cells::Char.new(value: 'm', position: [1, 6]),
              Vedeu::Cells::Char.new(value: 'i', position: [1, 7]),
              Vedeu::Cells::Char.new(value: 'n', position: [1, 8]),
              Vedeu::Cells::Char.new(value: ' ', position: [1, 9]),
              Vedeu::Views::Char.new(value: '-', position: [1, 10], border: type),
            ]
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new('Vanadium') }

          it { subject.must_equal(false) }
        end
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { instance.must_respond_to(:to_str) }

        it { subject.must_equal('Aluminium') }
      end

      describe '#value' do
        subject { instance.value }

        it { instance.must_respond_to(:title) }
        it { instance.must_respond_to(:caption) }

        context 'when the value is nil' do
          let(:_value) {}

          it { subject.must_equal('') }
        end

        context 'when the value is not nil' do
          it { subject.must_equal('Aluminium') }
        end
      end

    end # Title

  end # Borders

end # Vedeu
