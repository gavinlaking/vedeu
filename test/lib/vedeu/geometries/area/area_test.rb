# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Geometries

    describe Area do

      let(:described) { Vedeu::Geometries::Area }
      let(:instance)  { described.new(name: _name, y: y, yn: yn, x: x, xn: xn) }
      let(:_name)     { :vedeu_geometries_area }
      let(:y)         { 4 }
      let(:yn)        { 9 }
      let(:x)         { 6 }
      let(:xn)        { 21 }
      let(:offset)    { 1 }

      let(:border_attributes) {
        {
          bottom_left:  'C',
          bottom_right: 'D',
          enabled:      enabled,
          horizontal:   'H',
          name:         _name,
          show_top:     top,
          show_bottom:  bottom,
          show_left:    left,
          show_right:   right,
          top_left:     'A',
          top_right:    'B',
          vertical:     'V'
        }
      }
      let(:enabled) { false }
      let(:top)     { false }
      let(:bottom)  { false }
      let(:left)    { false }
      let(:right)   { false }
      let(:border)  { Vedeu::Borders::Border.new(border_attributes) }
      let(:border_attributes) {
        {
          enabled: enabled
        }
      }

      before do
        Vedeu.borders.stubs(:by_name).returns(border)
      end

      describe '#y' do
        it { instance.must_respond_to(:y) }
      end

      describe '#yn' do
        it { instance.must_respond_to(:yn) }
      end

      describe '#x' do
        it { instance.must_respond_to(:x) }
      end

      describe '#xn' do
        it { instance.must_respond_to(:xn) }
      end

      describe '#top' do
        it { instance.must_respond_to(:top) }
      end

      describe '#bottom' do
        it { instance.must_respond_to(:bottom) }
      end

      describe '#left' do
        it { instance.must_respond_to(:left) }
      end

      describe '#right' do
        it { instance.must_respond_to(:right) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@yn').must_equal(yn) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@xn').must_equal(xn) }
      end

      describe '.from_attributes' do
        let(:attributes) {
          {
            y:                    y,
            yn:                   yn,
            height:               height,
            x:                    x,
            xn:                   xn,
            width:                width,
            maximised:            maximised,
            name:                 _name,
            horizontal_alignment: horizontal_alignment,
            vertical_alignment:   vertical_alignment,
          }
        }
        let(:y)                    {}
        let(:yn)                   {}
        let(:height)               {}
        let(:x)                    {}
        let(:xn)                   {}
        let(:width)                {}
        let(:maximised)            {}
        let(:horizontal_alignment) {}
        let(:vertical_alignment)   {}

        subject { described.from_attributes(attributes) }

        it { subject.must_be_instance_of(described) }
      end

      describe '#eql?' do
        let(:other) { described.new(name: _name, y: 4, yn: 9, x: 6, xn: 21) }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(name: _name, y: 1, yn: 25, x: 1, xn: 40) }

          it { subject.must_equal(false) }
        end
      end

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#bordered_width' do
        subject { instance.bordered_width }

        context 'when the border is not enabled' do
          let(:enabled) { false }

          it 'returns the interface width' do
            subject.must_equal(16)
          end
        end

        context 'when the border is enabled' do
          context 'when both left and right borders are shown' do
            let(:border_attributes) {
              {
                enabled: true,
                name:    _name,
              }
            }

            it { subject.must_equal(14) }
          end

          context 'when either the left or right border is shown' do
            let(:border_attributes) {
              {
                enabled:   true,
                name:      _name,
                show_left: false
              }
            }

            it { subject.must_equal(15) }
          end

          context 'when neither left nor right borders are shown' do
            let(:border_attributes) {
              {
                enabled:    true,
                name:       _name,
                show_left:  false,
                show_right: false
              }
            }

            it { subject.must_equal(16) }
          end
        end
      end

      describe '#bordered_height' do
        subject { instance.bordered_height }

        context 'when the border is not enabled' do
          it 'returns the interface height' do
            subject.must_equal(6)
          end
        end

        context 'when the border is enabled' do
          context 'when both top and bottom borders are shown' do
            let(:border_attributes) {
              {
                enabled: true,
                name:    _name,
              }
            }

            it { subject.must_equal(4) }
          end

          context 'when either the top or bottom border is shown' do
            let(:border_attributes) {
              {
                enabled:  true,
                name:     _name,
                show_top: false
              }
            }

            it { subject.must_equal(5) }
          end

          context 'when neither top nor bottom borders are shown' do
            let(:border_attributes) {
              {
                enabled:     true,
                name:        _name,
                show_top:    false,
                show_bottom: false
              }
            }

            it { subject.must_equal(6) }
          end
        end
      end

      describe '#bx' do
        subject { instance.bx }

        context 'when enabled' do
          let(:enabled) { true }
          let(:left) { true }

          it { subject.must_equal(7) }
        end

        context 'when not enabled or without left' do
          it { subject.must_equal(6) }
        end
      end

      describe '#bxn' do
        subject { instance.bxn }

        context 'when enabled' do
          let(:enabled) { true }
          let(:right) { true }

          it { subject.must_equal(20) }
        end

        context 'when not enabled or without right' do
          it { subject.must_equal(21) }
        end
      end

      describe '#by' do
        subject { instance.by }

        context 'when enabled' do
          let(:enabled) { true }
          let(:top) { true }

          it { subject.must_equal(5) }
        end

        context 'when not enabled or without top' do
          it { subject.must_equal(4) }
        end
      end

      describe '#byn' do
        subject { instance.byn }

        context 'when enabled' do
          let(:enabled) { true }
          let(:bottom) { true }

          it { subject.must_equal(8) }
        end

        context 'when not enabled or without bottom' do
          it { subject.must_equal(9) }
        end
      end

      describe '#centre' do
        subject { instance.centre }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([7, 14]) }
      end

      describe '#centre_y' do
        subject { instance.centre_y }

        it { subject.class < Integer }
        it { subject.must_equal(7) }
      end

      describe '#centre_x' do
        subject { instance.centre_x }

        it { subject.class < Integer }
        it { subject.must_equal(14) }
      end

      describe '#height' do
        subject { instance.height }

        it { subject.class < Integer }

        context 'when a starting coordinate and height is given' do
          let(:y)       { 3 }
          let(:height)  { 10 }
          let(:subject) { described.from_attributes(y: y, height: height).height }

          it { subject.must_equal(10) }
        end

        context 'when a starting and ending coordinate is given' do
          let(:y)  { 3 }
          let(:yn) { 13 }
          let(:subject) { described.from_attributes(y: y, yn: yn).height }

          it { subject.must_equal(11) }
        end
      end

      describe '#width' do
        subject { instance.width }

        it { subject.class < Integer }

        # it { subject.must_equal(16) }
      end

      describe '#north' do
        subject { instance.north(offset) }

        it { subject.class < Integer }

        context 'with the default offset' do
          it { subject.must_equal(3) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(6) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(2) }
        end
      end

      describe '#east' do
        subject { instance.east(offset) }

        it { subject.class < Integer }

        context 'with the default offset' do
          it { subject.must_equal(22) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(19) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(23) }
        end
      end

      describe '#south' do
        subject { instance.south(offset) }

        it { subject.class < Integer }

        context 'with the default offset' do
          it { subject.must_equal(10) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(7) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(11) }
        end
      end

      describe '#west' do
        subject { instance.west(offset) }

        it { subject.class < Integer }

        context 'with the default offset' do
          it { subject.must_equal(5) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(8) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(4) }
        end
      end

    end # Area

  end # Geometries

end # Vedeu
