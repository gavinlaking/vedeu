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
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@attributes').must_equal(
        {
          bottom_left:  'm',
          bottom_right: 'j',
          client:       nil,
          colour:       {},
          enabled:      false,
          horizontal:   'q',
          name:         'borders',
          show_bottom:  true,
          show_left:    true,
          show_right:   true,
          show_top:     true,
          style:        [],
          top_left:     'l',
          top_right:    'k',
          vertical:     'x',
        })
      }
      it { instance.instance_variable_get('@colour').must_equal({}) }
      it { instance.instance_variable_get('@name').must_equal('borders') }
      it { instance.instance_variable_get('@repository').must_be_instance_of(Vedeu::Borders) }
      it { instance.instance_variable_get('@style').must_equal([]) }
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

    describe '#colour=' do
      let(:value) { { foreground: '#00ff00' } }

      subject { instance.colour=(value) }

      it { subject; instance.instance_variable_get("@colour").must_be_instance_of(Colour) }
    end

    describe '#style=' do
      let(:value) { 'normal' }

      subject { instance.style=(value) }

      it { subject; instance.instance_variable_get("@style").must_be_instance_of(Style) }
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

    describe '#to_s' do
      subject { instance.to_s }

      context 'when all borders should be shown' do
        before do
          Vedeu.border 'borders' do
            # ...
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "\e(0l\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0k\e(B
\e(0x\e(BBeryll\e(0x\e(B
\e(0x\e(BMagnes\e(0x\e(B
\e(0x\e(BPluton\e(0x\e(B
\e(0m\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0j\e(B"
          )
        end
      end

      context 'when no borders are shown' do
        before do
          Vedeu.border 'borders' do
            show_bottom false
            show_left   false
            show_right  false
            show_top    false
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "Potassiu\n" \
            "Lanthanu"
          )
        end
      end

      context 'when the left and right border is not shown' do
        before do
          Vedeu.border 'borders' do
            show_left   false
            show_right  false
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\n" \
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B"
          )
        end
      end

      context 'when the top and bottom border is not shown' do
        before do
          Vedeu.border 'borders' do
            show_bottom false
            show_top    false
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "\e(0x\e(BBeryll\e(0x\e(B\n" \
            "\e(0x\e(BMagnes\e(0x\e(B\n" \
            "\e(0x\e(BPluton\e(0x\e(B\n" \
            "\e(0x\e(BPotass\e(0x\e(B\n" \
            "\e(0x\e(BLantha\e(0x\e(B"
          )
        end
      end

      context 'when the left border is shown, all others not shown' do
        before do
          Vedeu.border 'borders' do
            show_bottom false
            show_right  false
            show_top    false
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "\e(0x\e(BBerylli\n" \
            "\e(0x\e(BMagnesi\n" \
            "\e(0x\e(BPlutoni\n" \
            "\e(0x\e(BPotassi\n" \
            "\e(0x\e(BLanthan"
          )
        end
      end

      context 'when the right border is shown, all others not shown' do
        before do
          Vedeu.border 'borders' do
            show_bottom false
            show_left   false
            show_top    false
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "Berylli\e(0x\e(B\n" \
            "Magnesi\e(0x\e(B\n" \
            "Plutoni\e(0x\e(B\n" \
            "Potassi\e(0x\e(B\n" \
            "Lanthan\e(0x\e(B" \
          )
        end
      end

      context 'when the top border is shown, all others not shown' do
        before do
          Vedeu.border 'borders' do
            show_bottom false
            show_left   false
            show_right  false
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\n" \
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "Potassiu"
          )
        end
      end

      context 'when the bottom border is shown, all others not shown' do
        before do
          Vedeu.border 'borders' do
            show_left   false
            show_right  false
            show_top    false
          end
        end

        it 'returns the escape sequences to draw a border' do
          subject.must_equal(
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "Potassiu\n" \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B"
          )
        end
      end
    end

  end # Border

end # Vedeu
