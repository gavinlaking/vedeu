require 'test_helper'

module Vedeu
  describe Stream do
    let(:stream) {
      Stream.new({
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        text:  'Some text',
        style: style,
        width: width,
        align: align
      })
    }
    let(:style) { 'normal' }
    let(:align) { :left }
    let(:width) { 9 }

    describe '#colour' do
      it 'has a colour attribute' do
        stream.colour.must_be_instance_of(Colour)
      end
    end

    describe '#text' do
      it 'has a text attribute' do
        stream.text.must_equal('Some text')
      end
    end

    describe '#style' do
      it 'has a style attribute' do
        stream.style.must_equal("\e[24m\e[21m\e[27m")
      end
    end

    describe '#width' do
      it 'has a width attribute' do
        stream.width.must_equal(9)
      end
    end

    describe '#align' do
      it 'has an align attribute' do
        stream.align.must_equal(:left)
      end
    end

    describe '#style' do
      describe 'for a single style' do
        let(:style) { 'normal' }

        it 'returns an escape sequence' do
          stream.style.must_equal("\e[24m\e[21m\e[27m")
        end
      end

      describe 'for multiple styles' do
        let(:style) { ['normal', 'underline'] }

        it 'returns an escape sequence for multiple styles' do
          stream.style.must_equal("\e[24m\e[21m\e[27m\e[4m")
        end
      end

      describe 'for an unknown style' do
        let(:style) { 'unknown' }

        it 'returns an empty string for an unknown style' do
          stream.style.must_equal('')
        end
      end

      describe 'for an empty or nil' do
        let(:style) { '' }

        it 'returns an empty string for empty or nil' do
          stream.style.must_equal('')
        end
      end
    end

    describe '#to_s' do
      describe 'when a width is set and align is default' do
        let(:width) { 20 }

        it 'returns a String' do
          stream.to_s.must_equal(
            "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
            "\e[24m\e[21m\e[27m"      \
            "Some text           "
          )
        end

        describe 'and align is :centre' do
          let(:align) { :centre }

          it 'returns a String' do
            stream.to_s.must_equal(
              "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
              "\e[24m\e[21m\e[27m"      \
              "     Some text      "
            )
          end
        end

        describe 'and align is :right' do
          let(:align) { :right }

          it 'returns a String' do
            stream.to_s.must_equal(
              "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
              "\e[24m\e[21m\e[27m"      \
              "           Some text"
            )
          end
        end
      end

      describe 'when a width is not set' do
        it 'returns a String' do
          stream.to_s.must_equal(
            "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
            "\e[24m\e[21m\e[27m"      \
            "Some text"
          )
        end
      end
    end
  end
end
