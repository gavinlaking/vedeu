require 'test_helper'
require 'vedeu/models/stream'

module Vedeu
  describe Stream do
    let(:stream) {
      Stream.new({
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        text:  'Some text',
        style: 'normal'
      })
    }

    it 'has a colour attribute' do
      stream.colour.must_be_instance_of(Colour)
    end

    it 'has a text attribute' do
      stream.text.must_equal('Some text')
    end

    it 'has a style attribute' do
      stream.style.must_equal("\e[24m\e[21m\e[27m")
    end

    describe '#to_s' do
      it 'returns a String' do
        stream.to_s.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[24m\e[21m\e[27m" \
          "Some text"
        )
      end
    end

    describe '#to_json' do
      it 'returns a String' do
        stream.to_json.must_equal("{\"colour\":{\"foreground\":\"#ff0000\",\"background\":\"#000000\"},\"style\":[\"normal\"],\"text\":\"Some text\"}")
      end
    end
  end
end
