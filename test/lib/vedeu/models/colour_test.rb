require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/colour'

module Vedeu
  describe Colour do
    describe '#background' do
      it 'returns an escape sequence' do
        Colour.new({
          background: '#000000'
        }).background.must_equal("\e[48;5;16m")
      end

      it 'returns an empty string if the value is empty' do
        Colour.new.background.must_equal('')
      end
    end

    describe '#foreground' do
      it 'returns an escape sequence' do
        Colour.new({
          foreground: '#ff0000'
        }).foreground.must_equal("\e[38;5;196m")
      end

      it 'returns an empty string if the value is empty' do
        Colour.new.foreground.must_equal('')
      end
    end

    describe '#css_background' do
      it 'returns an escape sequence' do
        Colour.new({
          background: '#000000'
        }).css_background.must_equal('#000000')
      end

      it 'returns an empty string if the value is nil' do
        Colour.new.css_background.must_equal('')
      end
    end

    describe '#css_foreground' do
      it 'returns an escape sequence' do
        Colour.new({
          foreground: '#ff0000'
        }).css_foreground.must_equal('#ff0000')
      end

      it 'returns an empty string if the value is nil' do
        Colour.new.css_foreground.must_equal('')
      end
    end

    describe '#to_json' do
      it 'returns the model as JSON' do
        Colour.new({
          foreground: '#ff0000',
          background: '#000000'
        }).to_json.must_equal("{\"foreground\":\"#ff0000\",\"background\":\"#000000\"}")
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

    describe '#as_hash' do
      it 'returns the model as a Hash' do
        Colour.new({
          foreground: '#ff0000',
          background: '#000000'
        }).as_hash.must_equal({ foreground: '#ff0000', background: '#000000' })
      end
    end
  end
end
