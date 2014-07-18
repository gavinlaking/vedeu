require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/stream'

module Vedeu
  describe Stream do
    it 'has a colour attribute' do
      stream = Stream.new({
        colour: { foreground: '#ff0000', background: '#000000' }
      })
      stream.colour.must_be_instance_of(Colour)
    end

    it 'has a text attribute' do
      stream = Stream.new({ text: 'Some text' })
      stream.text.must_equal('Some text')
    end

    it 'has a style attribute' do
      stream = Stream.new({ style: 'normal' })
      stream.style.must_equal("\e[24m\e[21m\e[27m")
    end

    describe '#to_s' do
      it 'returns a String' do
        stream = Stream.new({
          colour: { foreground: '#ff0000', background: '#000000' },
          style:  'normal',
          text:   'Some text'
        })

        stream.to_s.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[24m\e[21m\e[27m" \
          "Some text"
        )
      end
    end

    describe '#to_json' do
      it 'returns a String' do
        stream = Stream.new({
          colour: { foreground: '#ff0000', background: '#000000' },
          style:  'normal',
          text:   'Some text'
        })

        stream.to_json.must_equal("{\"colour\":{\"foreground\":\"#ff0000\",\"background\":\"#000000\"},\"style\":[\"normal\"],\"text\":\"Some text\"}")
      end
    end
  end
end
