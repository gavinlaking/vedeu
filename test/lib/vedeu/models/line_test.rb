require 'test_helper'

module Vedeu
  describe Line do
    let(:line) {
      Line.new({
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        streams: [],
        style:   'normal'
      })
    }

    describe '#attributes' do
      it 'returns the attributes' do
        line.attributes.must_equal(
          {
            colour: {
              foreground: '#ff0000',
              background: '#000000'
            },
            streams: [],
            style: 'normal'
          }
        )
      end
    end

    describe '#colour' do
      it 'has a colour attribute' do
        line.colour.must_be_instance_of(Colour)
      end
    end

    describe '#streams' do
      it 'has a streams attribute' do
        line.streams.must_equal([])
      end
    end

    describe '#style' do
      it 'has a style attribute' do
        line.style.must_equal("\e[24m\e[21m\e[27m")
      end
    end

    describe '#to_s' do
      it 'returns a String' do
        line.to_s.must_equal(
          "\e[38;5;196m\e[48;5;16m" \
          "\e[24m\e[21m\e[27m"
        )
      end
    end
  end
end
