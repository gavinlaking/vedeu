require 'test_helper'
require 'vedeu/output/colour_translator'

module Vedeu
  describe ColourTranslator do
    describe '#translate' do
      {
        '#ff0000' => 196, # red
        '#00ff00' => 46,  # green
        '#0000ff' => 21,  # blue
        '#ffffff' => 231, # white
        '#aadd00' => 148, # lime green
        '#b94f1c' => 130, # sunset orange
      }.map do |html_colour, terminal_colour|
        it 'translation is performed' do
          ColourTranslator.translate(html_colour)
            .must_equal(terminal_colour)
        end
      end

      it 'returns empty string when not present' do
        ColourTranslator.translate.must_equal('')
      end

      it 'returns empty string when the wrong type!' do
        ColourTranslator.translate(:wrong_type).must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.translate('345678').must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.translate('#h11111').must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.translate('#1111').must_equal('')
      end
    end
  end
end
