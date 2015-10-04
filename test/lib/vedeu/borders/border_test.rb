require 'test_helper'

module Vedeu

  module Borders

    describe Border do

      let(:described)  { Vedeu::Borders::Border }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          bottom_left:  'm',
          bottom_right: 'j',
          caption:      '',
          client:       nil,
          colour:       nil,
          enabled:      false,
          horizontal:   'q',
          name:         _name,
          parent:       nil,
          repository:   Vedeu.borders,
          show_bottom:  true,
          show_left:    true,
          show_right:   true,
          show_top:     true,
          style:        nil,
          title:        '',
          top_left:     'l',
          top_right:    'k',
          vertical:     'x',
        }
      }
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
        it do
          instance.instance_variable_get('@attributes').
            must_equal(attributes)
        end
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:attributes=)
          instance.must_respond_to(:bottom_left)
          instance.must_respond_to(:bottom_left=)
          instance.must_respond_to(:bottom_right)
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
          instance.must_respond_to(:top_left)
          instance.must_respond_to(:top_left=)
          instance.must_respond_to(:top_right)
          instance.must_respond_to(:top_right=)
          instance.must_respond_to(:vertical)
          instance.must_respond_to(:vertical=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:enabled)
          instance.must_respond_to(:enabled=)
          instance.must_respond_to(:enabled?)
        }
      end

      describe 'border offset methods; bx, bxn, by, byn' do
        let(:attributes) {
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
        let(:_name)   { 'Border#bxbxnbybyn' }
        let(:enabled) { false }
        let(:top)     { false }
        let(:bottom)  { false }
        let(:left)    { false }
        let(:right)   { false }
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: _name,
                                        x:    2,
                                        xn:   6,
                                        y:    2,
                                        yn:   6)
        }

        before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

        describe '#bx' do
          subject { instance.bx }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with left' do
              let(:left) { true }

              it { subject.must_equal(3) }
            end

            context 'without left' do
              it { subject.must_equal(2) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(2) }
          end
        end

        describe '#bxn' do
          subject { instance.bxn }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with right' do
              let(:right) { true }

              it { subject.must_equal(5) }
            end

            context 'without right' do
              it { subject.must_equal(6) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(6) }
          end
        end

        describe '#by' do
          subject { instance.by }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with top' do
              let(:top) { true }

              it { subject.must_equal(3) }
            end

            context 'without top' do
              it { subject.must_equal(2) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(2) }
          end
        end

        describe '#byn' do
          subject { instance.byn }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with bottom' do
              let(:bottom) { true }

              it { subject.must_equal(5) }
            end

            context 'without bottom' do
              it { subject.must_equal(6) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(6) }
          end
        end
      end

      describe '#width' do
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: _name, width: 8)
        }

        before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

        subject { instance.width }

        context 'when the border is not enabled' do
          it 'returns the interface width' do
            subject.must_equal(8)
          end
        end

        context 'when the border is enabled' do
          context 'when both left and right borders are shown' do
            let(:attributes) {
              {
                enabled: true,
                name:    _name,
              }
            }

            it { subject.must_equal(6) }
          end

          context 'when either the left or right border is shown' do
            let(:attributes) {
              {
                enabled:   true,
                name:      _name,
                show_left: false
              }
            }

            it { subject.must_equal(7) }
          end

          context 'when neither left nor right borders are shown' do
            let(:attributes) {
              {
                enabled:    true,
                name:       _name,
                show_left:  false,
                show_right: false
              }
            }

            it { subject.must_equal(8) }
          end
        end
      end

      describe '#height' do
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: _name, height: 5)
        }

        before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

        subject { instance.height }

        context 'when the border is not enabled' do
          it 'returns the interface height' do
            subject.must_equal(5)
          end
        end

        context 'when the border is enabled' do
          context 'when both top and bottom borders are shown' do
            let(:attributes) {
              {
                enabled: true,
                name:    _name,
              }
            }

            it { subject.must_equal(3) }
          end

          context 'when either the top or bottom border is shown' do
            let(:attributes) {
              {
                enabled:  true,
                name:     _name,
                show_top: false
              }
            }

            it { subject.must_equal(4) }
          end

          context 'when neither top nor bottom borders are shown' do
            let(:attributes) {
              {
                enabled:     true,
                name:        _name,
                show_top:    false,
                show_bottom: false
              }
            }

            it { subject.must_equal(5) }
          end
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
