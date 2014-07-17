require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/line'

module Vedeu
  describe Line do
    it 'has a style attribute' do
      Line.new(style:  'normal').style.must_be_instance_of(String)
    end

    it 'has a colour attribute' do
      Line.new({
        colour: { foreground: '#ff0000', background: '#000000' }
      }).colour.must_be_instance_of(Colour)
    end

    it 'has a model attribute' do
      Line.new(model: {}).model.must_be_instance_of(Hash)
    end

    it 'has a streams attribute' do
      Line.new(streams: []).streams.must_equal([])
    end

    describe '#to_json' do
      it 'returns an String' do
        Line.new({
          style:   'normal',
          colour:  { foreground: '#ff0000', background: '#000000' },
          streams: [],
        }).to_json.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\\u001b[24m\\u001b[21m\\u001b[27m\",\"streams\":[]}")
      end
    end

    describe '#to_s' do
      it 'returns an String' do
        Line.new({
          style:  'normal',
          colour: { foreground: '#ff0000', background: '#000000' },
        }).to_s.must_equal("\e[38;5;196m\e[48;5;16m\e[24m\e[21m\e[27m")
      end
    end
  end
end
