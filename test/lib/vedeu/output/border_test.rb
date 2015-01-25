require 'test_helper'

module Vedeu

  describe Border do

    let(:described)  { Vedeu::Border }
    let(:instance)   { described.new(interface, attributes) }
    # let(:interface)  { Interface.new({ name: 'caesium' }) }
    let(:interface)  {
      Vedeu::Interface.build do
        geometry do
          height 5
          width  8
        end
        name 'caesium'
      end
    }
    let(:attributes) { {} }

    before do
      interface.lines = [
        Line.new([Stream.new('Beryllium')]),
        Line.new([Stream.new('Magnesium')]),
        Line.new([Stream.new('Plutonium')]),
        Line.new([Stream.new('Potassium')]),
        Line.new([Stream.new('Lanthanum')]),
        Line.new([Stream.new('Stront­ium')])
      ]
    end

    describe '.build' do
      subject {
        described.build(interface, attributes) do
          horizontal '~'
        end
      }

      it { subject.must_be_instance_of(described) }
    end

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Border) }
      it { subject.instance_variable_get('@interface').must_equal(interface) }
      it { subject.instance_variable_get('@attributes').must_equal(
        {
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
        let(:attributes) { { enabled: true } }

        it { subject.must_be_instance_of(TrueClass) }
      end
    end

    describe '#bottom?' do
      subject { instance.bottom? }

      it { subject.must_be_instance_of(TrueClass) }

      context 'when false' do
        let(:attributes) { { show_bottom: false } }

        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#left?' do
      subject { instance.left? }

      it { subject.must_be_instance_of(TrueClass) }

      context 'when false' do
        let(:attributes) { { show_left: false } }

        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#right?' do
      subject { instance.right? }

      it { subject.must_be_instance_of(TrueClass) }

      context 'when false' do
        let(:attributes) { { show_right: false } }

        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#top?' do
      subject { instance.top? }

      it { subject.must_be_instance_of(TrueClass) }

      context 'when false' do
        let(:attributes) { { show_top: false } }

        it { subject.must_be_instance_of(FalseClass) }
      end
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
