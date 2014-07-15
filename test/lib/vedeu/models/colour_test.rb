require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Colour do
    describe '#to_json' do
      it 'returns the model as JSON' do
        Colour.new({
          foreground: '#ff0000',
          background: '#000000'
        }).to_json.must_equal("{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"}")
      end
    end

    describe '#to_s' do
      it 'returns an escape sequence' do
        Colour.new({
          foreground: '#ff0000',
          background: '#000000'
        }).to_s.must_equal("\e[38;5;196m\e[48;5;16m")
      end

      it 'returns an escape sequence when the foreground is missing' do
        Colour.new({
          background: '#000000'
        }).to_s.must_equal("\e[48;5;16m")
      end

      it 'returns an escape sequence when the background is missing' do
        Colour.new({
          foreground: '#ff0000',
        }).to_s.must_equal("\e[38;5;196m")
      end

      it 'returns an empty string when both are missing' do
        Colour.new.to_s.must_equal('')
      end
    end
  end
end
