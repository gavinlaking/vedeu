require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/line'

module Vedeu
  describe Line do
    let(:line) {
      Line.new({
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        model:   {},
        streams: [],
        style:   'normal'
      })
    }

    it 'has a colour attribute' do
      line.colour.must_be_instance_of(Colour)
    end

    it 'has a model attribute' do
      line.model.must_be_instance_of(Hash)
    end

    it 'has a streams attribute' do
      line.streams.must_equal([])
    end

    describe '#to_json' do
      it 'returns an String' do
        line.to_json.must_equal("{\"colour\":{\"foreground\":\"#ff0000\",\"background\":\"#000000\"},\"style\":[\"normal\"],\"streams\":[]}")
      end
    end

    describe '#to_s' do
      it 'returns an String' do
        line.to_s.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[24m\e[21m\e[27m"
        )
      end
    end
  end
end
