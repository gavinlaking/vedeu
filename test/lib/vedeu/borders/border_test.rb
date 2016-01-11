# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Borders

    describe Border do

      let(:described)  { Vedeu::Borders::Border }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          bottom_horizontal: bottom_horizontal,
          bottom_left:       bottom_left,
          bottom_right:      bottom_right,
          caption:      '',
          client:       nil,
          colour:       nil,
          enabled:      false,
          horizontal:   'q',
          left_vertical: left_vertical,
          name:         _name,
          parent:       nil,
          repository:   Vedeu.borders,
          right_vertical: right_vertical,
          show_bottom:  true,
          show_left:    true,
          show_right:   true,
          show_top:     true,
          style:        nil,
          title:        '',
          top_horizontal: top_horizontal,
          top_left:       top_left,
          top_right:      top_right,
          vertical:     'x',
        }
      }
      let(:bottom_horizontal) { 'B' }
      let(:bottom_left)       { 'm' }
      let(:bottom_right)      { 'j' }
      let(:left_vertical)     { 'L' }
      let(:right_vertical)    { 'R' }
      let(:top_horizontal)    { 'T' }
      let(:top_left)          { 'l' }
      let(:top_right)         { 'k' }
      let(:geometry) {}
      let(:_name)    { 'borders' }

      describe '.build' do
        subject {
          described.build(attributes) do
            horizontal '~'
          end
        }

        it { subject.must_be_instance_of(described) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe '#attributes' do
        it { instance.must_respond_to(:attributes) }
      end

      describe '#bottom_horizontal=' do
        it { instance.must_respond_to(:bottom_horizontal=) }
      end

      describe '#bottom_left=' do
        it { instance.must_respond_to(:bottom_left=) }
      end

      describe '#bottom_right=' do
        it { instance.must_respond_to(:bottom_right=) }
      end

      describe '#caption' do
        it { instance.must_respond_to(:caption) }
      end

      describe '#caption=' do
        let(:_value) { 'some caption' }

        subject { instance.caption=(_value) }

        it {
          instance.caption.must_equal('')
          instance.expects(:store)
          subject
          instance.caption.must_equal(_value)
        }
      end

      describe '#horizontal' do
        it { instance.must_respond_to(:horizontal) }
      end

      describe '#horizontal=' do
        it { instance.must_respond_to(:horizontal=) }
      end

      describe '#show_bottom' do
        it { instance.must_respond_to(:show_bottom) }
      end

      describe '#bottom?' do
        it { instance.must_respond_to(:bottom?) }
      end

      describe '#show_bottom=' do
        it { instance.must_respond_to(:show_bottom=) }
      end

      describe '#show_left' do
        it { instance.must_respond_to(:show_left) }
      end

      describe '#left?' do
        it { instance.must_respond_to(:left?) }
      end

      describe '#show_left=' do
        it { instance.must_respond_to(:show_left=) }
      end

      describe '#show_right' do
        it { instance.must_respond_to(:show_right) }
      end

      describe '#right?' do
        it { instance.must_respond_to(:right?) }
      end

      describe '#show_right=' do
        it { instance.must_respond_to(:show_right=) }
      end

      describe '#show_top' do
        it { instance.must_respond_to(:show_top) }
      end

      describe '#top?' do
        it { instance.must_respond_to(:top?) }
      end

      describe '#show_top=' do
        it { instance.must_respond_to(:show_top=) }
      end

      describe '#title' do
        it { instance.must_respond_to(:title) }
      end

      describe '#title=' do
        let(:_value) { 'some title' }

        subject { instance.title=(_value) }

        it {
          instance.title.must_equal('')
          instance.expects(:store)
          subject
          instance.title.must_equal(_value)
        }
      end

      describe '#top_horizontal=' do
        it { instance.must_respond_to(:top_horizontal=) }
      end

      describe '#top_left=' do
        it { instance.must_respond_to(:top_left=) }
      end

      describe '#top_right=' do
        it { instance.must_respond_to(:top_right=) }
      end

      describe '#left_vertical=' do
        it { instance.must_respond_to(:left_vertical=) }
      end

      describe '#right_vertical=' do
        it { instance.must_respond_to(:right_vertical=) }
      end

      describe '#vertical' do
        it { instance.must_respond_to(:vertical) }
      end

      describe '#vertical=' do
        it { instance.must_respond_to(:vertical=) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#enabled' do
        it { instance.must_respond_to(:enabled) }
      end

      describe '#enabled=' do
        it { instance.must_respond_to(:enabled=) }
      end

      describe '#enabled?' do
        it { instance.must_respond_to(:enabled?) }
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::Borders::DSL)
        end
      end

      describe '#bottom_horizontal' do
        subject { instance.bottom_horizontal }

        context 'when a custom border is specified' do
          it { subject.must_equal(bottom_horizontal) }
        end

        context 'when a custom border is not specified' do
          let(:bottom_horizontal) {}

          it { subject.must_be_instance_of(Vedeu::Cells::BottomHorizontal) }
        end
      end

      describe '#bottom_left' do
        subject { instance.bottom_left }

        context 'when a custom border is specified' do
          it { subject.must_equal(bottom_left) }
        end

        context 'when a custom border is not specified' do
          let(:bottom_left) {}

          it { subject.must_be_instance_of(Vedeu::Cells::BottomLeft) }
        end
      end

      describe '#bottom_right' do
        subject { instance.bottom_right }

        context 'when a custom border is specified' do
          it { subject.must_equal(bottom_right) }
        end

        context 'when a custom border is not specified' do
          let(:bottom_right) {}

          it { subject.must_be_instance_of(Vedeu::Cells::BottomRight) }
        end
      end

      describe '#left_vertical' do
        subject { instance.left_vertical }

        context 'when a custom border is specified' do
          it { subject.must_equal(left_vertical) }
        end

        context 'when a custom border is not specified' do
          let(:left_vertical) {}

          it { subject.must_be_instance_of(Vedeu::Cells::LeftVertical) }
        end
      end

      describe '#right_vertical' do
        subject { instance.right_vertical }

        context 'when a custom border is specified' do
          it { subject.must_equal(right_vertical) }
        end

        context 'when a custom border is not specified' do
          let(:right_vertical) {}

          it { subject.must_be_instance_of(Vedeu::Cells::RightVertical) }
        end
      end

      describe '#top_horizontal' do
        subject { instance.top_horizontal }

        context 'when a custom border is specified' do
          it { subject.must_equal(top_horizontal) }
        end

        context 'when a custom border is not specified' do
          let(:top_horizontal) {}

          it { subject.must_be_instance_of(Vedeu::Cells::TopHorizontal) }
        end
      end

      describe '#top_left' do
        subject { instance.top_left }

        context 'when a custom border is specified' do
          it { subject.must_equal(top_left) }
        end

        context 'when a custom border is not specified' do
          let(:top_left) {}

          it { subject.must_be_instance_of(Vedeu::Cells::TopLeft) }
        end
      end

      describe '#top_right' do
        subject { instance.top_right }

        context 'when a custom border is specified' do
          it { subject.must_equal(top_right) }
        end

        context 'when a custom border is not specified' do
          let(:top_right) {}

          it { subject.must_be_instance_of(Vedeu::Cells::TopRight) }
        end
      end

      describe '#enabled?' do
        subject { instance.enabled? }

        it { subject.must_be_instance_of(FalseClass) }

        context 'when true' do
          let(:attributes) {
            {
              enabled: true,
              name:    _name,
            }
          }

          it { subject.must_be_instance_of(TrueClass) }
        end
      end

      describe '#bottom?' do
        subject { instance.bottom? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:     true,
              name:        _name,
              show_bottom: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#left?' do
        subject { instance.left? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:   true,
              name:      _name,
              show_left: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#right?' do
        subject { instance.right? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:    true,
              name:       _name,
              show_right: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#top?' do
        subject { instance.top? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:  true,
              name:     _name,
              show_top: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

    end # Border

  end # Borders

end # Vedeu
