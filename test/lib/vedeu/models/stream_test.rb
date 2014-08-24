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
        stream.style.must_be_instance_of(Style)
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

    describe '#to_s' do
      describe 'when a width is set and align is default' do
        let(:width) { 20 }

        it 'returns a String' do
          stream.to_s.must_equal(
            "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
            "\e[24m\e[22m\e[27m"      \
            "Some text           "
          )
        end

        describe 'and align is :centre' do
          let(:align) { :centre }

          it 'returns a String' do
            stream.to_s.must_equal(
              "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
              "\e[24m\e[22m\e[27m"      \
              "     Some text      "
            )
          end
        end

        describe 'and align is :right' do
          let(:align) { :right }

          it 'returns a String' do
            stream.to_s.must_equal(
              "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
              "\e[24m\e[22m\e[27m"      \
              "           Some text"
            )
          end
        end
      end

      describe 'when a width is not set' do
        it 'returns a String' do
          stream.to_s.must_equal(
            "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
            "\e[24m\e[22m\e[27m"      \
            "Some text"
          )
        end
      end
    end
  end
end
