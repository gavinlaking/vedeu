require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/stream'

module Vedeu
  describe Stream do
    it 'has a colour attribute' do
      Stream.new({
        colour: { foreground: '#ff0000', background: '#000000' }
      }).colour.must_be_instance_of(Colour)
    end

    it 'has a text attribute' do
      Stream.new({ text: 'Some text' }).text.must_equal('Some text')
    end

    it 'has a style attribute' do
      Stream.new({ style: 'normal' }).style
        .must_equal("\e[24m\e[21m\e[27m")
    end

    describe '#to_s' do
      it 'returns a String' do
        Stream.new({
          style:  'normal',
          colour: { foreground: '#ff0000', background: '#000000' },
          text:   'Some text'
        }).to_s.must_equal("\e[38;5;196m\e[48;5;16m\e[24m\e[21m\e[27mSome text")
      end
    end

    describe '#to_json' do
      it 'returns a String' do
        Stream.new({
          style:  'normal',
          colour: { foreground: '#ff0000', background: '#000000' },
          text:   'Some text'
        }).to_json.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\\u001b[24m\\u001b[21m\\u001b[27m\",\"text\":\"Some text\"}")
      end
    end
  end
end
