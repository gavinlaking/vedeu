# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Borders

    describe Caption do

      let(:described) { Vedeu::Borders::Caption }
      let(:instance)  { described.new(_name, _value, horizontal) }
      let(:_name)     { :vedeu_borders_caption }
      let(:_value)    { 'Bismuth' }
      let(:type)      { :bottom_horizontal }
      let(:horizontal) {
        [
          Vedeu::Cells::BottomHorizontal.new(position: [4, 1]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 2]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 3]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 4]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 5]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 6]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 7]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 8]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 9]),
          Vedeu::Cells::BottomHorizontal.new(position: [4, 10]),
        ]
      }

      describe '#render' do
        subject { instance.render }

        context 'when the caption is empty' do
          let(:_value) {}

          it { subject.must_equal(horizontal) }
        end

        context 'when the caption is not empty' do
          let(:border)   {
            Vedeu::Borders::Border.new(name: _name)
          }
          let(:geometry) {
            Vedeu::Geometries::Geometry.new(name: _name,
                                            x:    1,
                                            xn:   10,
                                            y:    1,
                                            yn:   4)
          }
          let(:expected) {
            [
              Vedeu::Cells::BottomHorizontal.new(position: [4, 1]),
              Vedeu::Cells::Char.new(value: ' ', position: [4, 2]),
              Vedeu::Cells::Char.new(value: 'B', position: [4, 3]),
              Vedeu::Cells::Char.new(value: 'i', position: [4, 4]),
              Vedeu::Cells::Char.new(value: 's', position: [4, 5]),
              Vedeu::Cells::Char.new(value: 'm', position: [4, 6]),
              Vedeu::Cells::Char.new(value: 'u', position: [4, 7]),
              Vedeu::Cells::Char.new(value: 't', position: [4, 8]),
              Vedeu::Cells::Char.new(value: ' ', position: [4, 9]),
              Vedeu::Cells::BottomHorizontal.new(position: [4, 10]),
            ]
          }

          before do
            Vedeu.borders.stubs(:by_name).returns(border)
            Vedeu.geometries.stubs(:by_name).returns(geometry)
          end

          it { subject.must_equal(expected) }
        end
      end

    end # Caption

  end # Borders

end # Vedeu
