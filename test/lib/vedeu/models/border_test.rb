require 'test_helper'

module Vedeu

  describe Border do
    let(:interface) { Interface.new({ geometry: { width: 8, height: 5 } }) }

    describe '#initialize' do
      it 'returns a new instance of Border' do
        Border.new(interface).must_be_instance_of(Border)
      end
    end

    describe '#to_s' do
      context 'when all borders should be shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface).to_s.must_equal(
            "\e(0l\e(B" \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B" \
            "\e(0k\e(B" \
            "\e(0x\e(B      \e(0x\e(B" \
            "\e(0x\e(B      \e(0x\e(B" \
            "\e(0x\e(B      \e(0x\e(B" \
            "\e(0m\e(B" \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B" \
            "\e(0j\e(B"
          )
        end
      end

      context 'when no borders are shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, {}, { show_bottom: false,
                                      show_left:   false,
                                      show_right:  false,
                                      show_top:    false }).to_s.must_equal(
            "        " \
            "        " \
            "        " \
            "        " \
            "        "
          )
        end
      end

      context 'when the left and right border is not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, {}, { show_left:   false,
                                      show_right:  false }).to_s.must_equal(
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B" \
            "        " \
            "        " \
            "        " \
            "        " \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B"
          )
        end
      end

      context 'when the top and bottom border is not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, {}, { show_bottom: false,
                                      show_top:    false }).to_s.must_equal(
            "\e(0x\e(B      \e(0x\e(B" \
            "\e(0x\e(B      \e(0x\e(B" \
            "\e(0x\e(B      \e(0x\e(B" \
            "\e(0x\e(B      \e(0x\e(B" \
            "\e(0x\e(B      \e(0x\e(B"
          )
        end
      end

      context 'when the left border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, {}, { show_bottom: false,
                                      show_right:  false,
                                      show_top:    false }).to_s.must_equal(
            "\e(0x\e(B       " \
            "\e(0x\e(B       " \
            "\e(0x\e(B       " \
            "\e(0x\e(B       " \
            "\e(0x\e(B       "
          )
        end
      end

      context 'when the right border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, {}, { show_bottom: false,
                                      show_left:   false,
                                      show_top:    false }).to_s.must_equal(
            "       \e(0x\e(B" \
            "       \e(0x\e(B" \
            "       \e(0x\e(B" \
            "       \e(0x\e(B" \
            "       \e(0x\e(B"
          )
        end
      end

      context 'when the top border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, {}, { show_bottom: false,
                                      show_left:   false,
                                      show_right:  false }).to_s.must_equal(
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B" \
            "        " \
            "        " \
            "        " \
            "        "
          )
        end
      end

      context 'when the bottom border is shown, all others not shown' do
        it 'returns the escape sequences to draw a border' do
          Border.new(interface, {}, { show_left:   false,
                                      show_right:  false,
                                      show_top:    false }).to_s.must_equal(
            "        " \
            "        " \
            "        " \
            "        " \
            "\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B\e(0q\e(B"
          )
        end
      end
    end

  end # Border

end # Vedeu
