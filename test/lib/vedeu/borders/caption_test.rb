require 'test_helper'

module Vedeu

  module Borders

    describe Caption do

      let(:described) { Vedeu::Borders::Caption }
      let(:instance)  { described.new(_value, chars) }
      let(:_value)    { 'Bismuth' }
      let(:chars)     {
        [
          Vedeu::Views::Char.new(value: '-', position: [4, 1], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 2], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 3], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 4], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 5], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 6], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 7], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 8], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 9], border: type),
          Vedeu::Views::Char.new(value: '-', position: [4, 10], border: type),
        ]
      }
      let(:type) { :bottom_horizontal }

      describe '#render' do
        subject { instance.render }

        context 'when the caption is empty' do
          let(:_value) {}

          it { subject.must_equal(chars) }
        end

        context 'when the caption is not empty' do
          let(:expected) {
            [
              Vedeu::Views::Char.new(value: '-', position: [4, 1], border: type),
              Vedeu::Views::Char.new(value: ' ', position: [4, 2], border: nil),
              Vedeu::Views::Char.new(value: 'B', position: [4, 3], border: nil),
              Vedeu::Views::Char.new(value: 'i', position: [4, 4], border: nil),
              Vedeu::Views::Char.new(value: 's', position: [4, 5], border: nil),
              Vedeu::Views::Char.new(value: 'm', position: [4, 6], border: nil),
              Vedeu::Views::Char.new(value: 'u', position: [4, 7], border: nil),
              Vedeu::Views::Char.new(value: 't', position: [4, 8], border: nil),
              Vedeu::Views::Char.new(value: ' ', position: [4, 9], border: nil),
              Vedeu::Views::Char.new(value: '-', position: [4, 10], border: type),
            ]
          }

          it { subject.must_equal(expected) }
        end
      end

    end # Caption

  end # Borders

end # Vedeu
