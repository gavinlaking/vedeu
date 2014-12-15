require 'test_helper'

module Vedeu

  describe Border do

    let(:described)  { Border.new(interface, attributes) }
    let(:interface)  { Interface.new({
        geometry: {
          width:  8,
          height: 5
        },
        lines: [
          { streams: [{ text: 'Beryllium' }] },
          { streams: [{ text: 'Magnesium' }] },
          { streams: [{ text: 'Plutonium' }] },
          { streams: [{ text: 'Potassium' }] },
          { streams: [{ text: 'Lanthanum' }] },
          { streams: [{ text: 'Stront­ium' }] },
        ]
      })
    }
    let(:attributes) { {  } }
    let(:options)    { {  } }

    describe '#initialize' do
      it { return_type_for(described, Border) }
      it { assigns(described, '@interface', interface) }
      it { assigns(described, '@attributes', {
          enabled:      false,
          show_bottom:  true,
          show_left:    true,
          show_right:   true,
          show_top:     true,
          bottom_right: 'j',
          top_right:    'k',
          top_left:     'l',
          bottom_left:  'm',
          horizontal:   'q',
          colour:       {},
          style:        [],
          vertical:     'x'
        })
      }
    end

    describe '#bottom?' do
      it { return_type_for(described.bottom?, TrueClass) }
    end

    describe '#left?' do
      it { return_type_for(described.left?, TrueClass) }
    end

    describe '#right?' do
      it { return_type_for(described.right?, TrueClass) }
    end

    describe '#top?' do
      it { return_type_for(described.top?, TrueClass) }
    end

    describe '#to_s' do
      context 'when all borders should be shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled: true }).to_s.must_equal(
            "\e(0l\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0k\e(B\n" \
            "\e(0x\e(BBeryll\e(0x\e(B\n" \
            "\e(0x\e(BMagnes\e(0x\e(B\n" \
            "\e(0x\e(BPluton\e(0x\e(B\n" \
            "\e(0m\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0j\e(B"
          )
        end
      end

      context 'when no borders are shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled:     true,
                                  show_bottom: false,
                                  show_left:   false,
                                  show_right:  false,
                                  show_top:    false }).to_s.must_equal(
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "Potassiu\n" \
            "Lanthanu"
          )
        end
      end

      context 'when the left and right border is not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled:     true,
                                  show_left:   false,
                                  show_right:  false }).to_s.must_equal(
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\n" \
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B"
          )
        end
      end

      context 'when the top and bottom border is not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled:     true,
                                  show_bottom: false,
                                  show_top:    false }).to_s.must_equal(
            "\e(0x\e(BBeryll\e(0x\e(B\n" \
            "\e(0x\e(BMagnes\e(0x\e(B\n" \
            "\e(0x\e(BPluton\e(0x\e(B\n" \
            "\e(0x\e(BPotass\e(0x\e(B\n" \
            "\e(0x\e(BLantha\e(0x\e(B"
          )
        end
      end

      context 'when the left border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled:     true,
                                  show_bottom: false,
                                  show_right:  false,
                                  show_top:    false }).to_s.must_equal(
            "\e(0x\e(BBerylli\n" \
            "\e(0x\e(BMagnesi\n" \
            "\e(0x\e(BPlutoni\n" \
            "\e(0x\e(BPotassi\n" \
            "\e(0x\e(BLanthan"
          )
        end
      end

      context 'when the right border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled:     true,
                                  show_bottom: false,
                                  show_left:   false,
                                  show_top:    false }).to_s.must_equal(
            "Berylli\e(0x\e(B\n" \
            "Magnesi\e(0x\e(B\n" \
            "Plutoni\e(0x\e(B\n" \
            "Potassi\e(0x\e(B\n" \
            "Lanthan\e(0x\e(B" \
          )
        end
      end

      context 'when the top border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled:     true,
                                  show_bottom: false,
                                  show_left:   false,
                                  show_right:  false }).to_s.must_equal(
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\n" \
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "Potassiu"
          )
        end
      end

      context 'when the bottom border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, { enabled:     true,
                                  show_left:   false,
                                  show_right:  false,
                                  show_top:    false }).to_s.must_equal(
            "Berylliu\n" \
            "Magnesiu\n" \
            "Plutoniu\n" \
            "Potassiu\n" \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B"
          )
        end
      end
    end

    describe '#to_viewport' do
      it 'returns a value like Viewport#show but with borders' do
        Border.new(interface, { enabled: true }).to_viewport.must_equal(
          [
            ["\e(0l\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0k\e(B"],
            ["\e(0x\e(B", "B", "e", "r", "y", "l", "l", "\e(0x\e(B"],
            ["\e(0x\e(B", "M", "a", "g", "n", "e", "s", "\e(0x\e(B"],
            ["\e(0x\e(B", "P", "l", "u", "t", "o", "n", "\e(0x\e(B"],
            ["\e(0m\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0q\e(B", "\e(0j\e(B"]
          ]
        )
      end
    end

  end # Border

end # Vedeu
