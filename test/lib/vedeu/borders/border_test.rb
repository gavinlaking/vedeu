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

      describe 'accessors' do
        it do
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:bottom_horizontal=)
          instance.must_respond_to(:bottom_left=)
          instance.must_respond_to(:bottom_right=)
          instance.must_respond_to(:caption)
          instance.must_respond_to(:caption=)
          instance.must_respond_to(:horizontal)
          instance.must_respond_to(:horizontal=)
          instance.must_respond_to(:show_bottom)
          instance.must_respond_to(:bottom?)
          instance.must_respond_to(:show_bottom=)
          instance.must_respond_to(:show_left)
          instance.must_respond_to(:left?)
          instance.must_respond_to(:show_left=)
          instance.must_respond_to(:show_right)
          instance.must_respond_to(:right?)
          instance.must_respond_to(:show_right=)
          instance.must_respond_to(:show_top)
          instance.must_respond_to(:top?)
          instance.must_respond_to(:show_top=)
          instance.must_respond_to(:title)
          instance.must_respond_to(:title=)
          instance.must_respond_to(:top_horizontal=)
          instance.must_respond_to(:top_left=)
          instance.must_respond_to(:top_right=)
          instance.must_respond_to(:left_vertical=)
          instance.must_respond_to(:right_vertical=)
          instance.must_respond_to(:vertical)
          instance.must_respond_to(:vertical=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:enabled)
          instance.must_respond_to(:enabled=)
          instance.must_respond_to(:enabled?)
        end
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
