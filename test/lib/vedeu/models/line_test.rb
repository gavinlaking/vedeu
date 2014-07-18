require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/line'

module Vedeu
  describe Line do
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
          colour:  { foreground: '#ff0000', background: '#000000' },
          style:   'normal',
          streams: [],
        }).to_json.must_equal("{\"colour\":{\"foreground\":\"#ff0000\",\"background\":\"#000000\"},\"style\":[\"normal\"],\"streams\":[]}")
      end
    end

    describe '#to_s' do
      it 'returns an String' do
        Line.new({
          colour: { foreground: '#ff0000', background: '#000000' },
          style:  'normal',
        }).to_s.must_equal("\e[38;5;196m\e[48;5;16m\e[24m\e[21m\e[27m")
      end
    end
  end
end
