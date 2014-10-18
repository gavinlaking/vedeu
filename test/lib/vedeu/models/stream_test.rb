require 'test_helper'

module Vedeu
  describe Stream do
    let(:stream) {
      Stream.new({
        colour: colour,
        parent: parent,
        text:  text,
        style: style,
        width: width,
        align: align
      })
    }
    let(:colour) {
      {
        foreground: '#ff0000',
        background: '#000000'
      }
    }
    let(:parent) { nil }
    let(:style)  { 'normal' }
    let(:text)   { 'Some text'}
    let(:align)  { :left }
    let(:width)  { 9 }

    describe '#initialize' do
      it 'returns an instance of itself' do
        attributes = {}
        Stream.new(attributes).must_be_instance_of(Stream)
      end
    end

    describe '#chars' do
      let(:parent) {
        {
          colour: {
            foreground: '#ffff00',
            background: '#0000ff'
          },
          style: []
        }
      }

      it 'returns an Array' do
        stream.chars.must_be_instance_of(Array)
      end

      context 'when there is content' do
        it 'returns a collection of strings containing escape sequences and ' \
           'content' do
          stream.chars.must_equal(
            [
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mS\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mo\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mm\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27me\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mt\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27me\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mx\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mt\e[38;2;255;255;0m\e[48;2;0;0;255m"
            ]
          )
        end
      end

      context 'when there is no content' do
        let(:text)  { '' }
        let(:width) { nil }

        it 'returns an empty collection' do
          stream.chars.must_equal([])
        end
      end

      context 'when there is no content but a width is set' do
        let(:text) { '' }

        it 'returns style and colours as appropriate' do
          stream.chars.must_equal(
            [
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m"
            ]
          )
        end
      end
    end

    describe '#empty?' do
      context 'when there is no content' do
        before { stream.stubs(:size).returns(0) }

        it { stream.empty?.must_equal(true) }
      end

      it 'returns false when there is content' do
        stream.empty?.must_equal(false)
      end
    end

    describe '#size' do
      it 'returns a Fixnum' do
        stream.size.must_be_instance_of(Fixnum)
      end

      it 'returns the size of the stream' do
        stream.size.must_equal(9)
      end
    end

    describe '#text' do
      it 'has a text attribute' do
        stream.text.must_equal('Some text')
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
      it 'reverts to the colours of the line after rendering itself' do
        line   = Line.new({
          colour: {
            foreground: '#00ff00',
            background: '#000000'
          },
          style: 'normal'
        })
        stream = Stream.new({
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          text:  'Some text',
          style: 'underline',
          width: nil,
          align: :left,
          parent: line.view_attributes,
        })
        stream.to_s.must_equal(
          "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
          "\e[4m" \
          "Some text" \
          "\e[24m\e[22m\e[27m" \
          "\e[38;2;0;255;0m\e[48;2;0;0;0m"
        )
      end

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
