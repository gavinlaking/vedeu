require 'test_helper'

module Vedeu

  describe Border do

    let(:described)  { Vedeu::Border }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        name: 'borders'
      }
    }

    before do
      Vedeu.interfaces.reset
      Vedeu.borders.reset
      Vedeu.interface 'borders' do
        geometry do
          height 5
          width  8
        end
        lines do
          line 'Beryllium'
          line 'Magnesium'
          line 'Plutonium'
          line 'Potassium'
          line 'Lanthanum'
          line 'Stront­ium'
        end
      end
    end

    describe '.build' do
      subject {
        described.build(attributes) do
          horizontal '~'
        end
      }

      it { subject.must_be_instance_of(described) }
    end

    describe '#initialize' do
      let(:default_attributes) {
        {
          bottom_left:  'm',
          bottom_right: 'j',
          client:       nil,
          colour:       nil,
          enabled:      false,
          horizontal:   'q',
          name:         'borders',
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
      it { instance.must_be_instance_of(described) }
      it do
        instance.instance_variable_get('@attributes').
          must_equal(default_attributes)
      end
      it { instance.instance_variable_get('@name').must_equal('borders') }
      it do
        instance.instance_variable_get('@repository').
          must_be_instance_of(Vedeu::Borders)
      end
    end

    describe 'border offset methods; bx, bxn, by, byn' do
      let(:attributes) {
        {
          bottom_left:  'C',
          bottom_right: 'D',
          enabled:      enabled,
          horizontal:   'H',
          name:         'Border#bxbxnbybyn',
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

      before do
        Vedeu.interfaces.reset
        Vedeu.borders.reset

        Vedeu.interface('Border#bxbxnbybyn') do
          geometry do
            x      2
            xn     6
            y      2
            yn     6
          end
        end
      end

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
              name:    'borders',
            }
          }

          it { subject.must_equal(6) }
        end

        context 'when either the left or right border is shown' do
          let(:attributes) {
            {
              enabled:   true,
              name:      'borders',
              show_left: false
            }
          }

          it { subject.must_equal(7) }
        end

        context 'when neither left nor right borders are shown' do
          let(:attributes) {
            {
              enabled:    true,
              name:       'borders',
              show_left:  false,
              show_right: false
            }
          }

          it { subject.must_equal(8) }
        end
      end
    end

    describe '#height' do
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
              name:    'borders',
            }
          }

          it { subject.must_equal(3) }
        end

        context 'when either the top or bottom border is shown' do
          let(:attributes) {
            {
              enabled:  true,
              name:     'borders',
              show_top: false
            }
          }

          it { subject.must_equal(4) }
        end

        context 'when neither top nor bottom borders are shown' do
          let(:attributes) {
            {
              enabled:     true,
              name:        'borders',
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
            name:    'borders',
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
            name:        'borders',
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
            name:      'borders',
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
            name:       'borders',
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
            name:     'borders',
            show_top: false,
          }
        }

        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#render' do
      let(:attributes) {
        {
          bottom_left:  'C',
          bottom_right: 'D',
          enabled:      enabled,
          horizontal:   'H',
          name:         'Border#render',
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
      let(:visibility) { true }

      before do
        Vedeu.interfaces.reset
        Vedeu.borders.reset

        Vedeu.interface('Border#render') do
          geometry do
            x      1
            xn     4
            y      1
            yn     4
          end
          visible(visibility)
        end
      end

      subject { instance.render }

      it { subject.must_be_instance_of(Array) }

      context 'when the interface is not visible' do
        let(:visibility) { false }

        it { subject.must_equal([]) }
      end

      context 'when the border is not enabled' do
        it { subject.must_equal([]) }
      end

      context 'when the border is enabled' do
        let(:enabled) { true }

        context 'top' do
          let(:top) { true }

          it { subject.size.must_equal(4) }
        end

        context 'right' do
          let(:right) { true }

          it { subject.size.must_equal(4) }
        end

        context 'bottom' do
          let(:bottom) { true }

          it { subject.size.must_equal(4) }
        end

        context 'left' do
          let(:left) { true }

          it { subject.size.must_equal(4) }
        end

        context 'top and right' do
          let(:top)   { true }
          let(:right) { true }

          it { subject.size.must_equal(7) }
        end

        context 'top and right and bottom' do
          let(:top)    { true }
          let(:right)  { true }
          let(:bottom) { true }

          it { subject.size.must_equal(10) }
        end

        context 'top and bottom' do
          let(:top)    { true }
          let(:bottom) { true }

          it { subject.size.must_equal(8) }
        end

        context 'top and left' do
          let(:top)  { true }
          let(:left) { true }

          it { subject.size.must_equal(7) }
        end

        context 'right and bottom' do
          let(:right)  { true }
          let(:bottom) { true }

          it { subject.size.must_equal(7) }
        end

        context 'right and left' do
          let(:right) { true }
          let(:left)  { true }

          it { subject.size.must_equal(8) }
        end

        context 'bottom and left' do
          let(:bottom) { true }
          let(:left)   { true }

          it { subject.size.must_equal(7) }
        end

        context 'all' do
          let(:top)    { true }
          let(:right)  { true }
          let(:bottom) { true }
          let(:left)   { true }

          it { subject.size.must_equal(12) }
        end

        context 'none' do
          it { subject.size.must_equal(0) }
        end
      end
    end

  end # Border

end # Vedeu
