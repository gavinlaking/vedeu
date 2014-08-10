require 'test_helper'
require 'vedeu/models/attributes/colour_translator'

module Vedeu
  describe ColourTranslator do
    describe '#background' do
      {
        '#5f0000' => "\e[48;5;52m",
        '#008700' => "\e[48;5;28m",
        '#0000d7' => "\e[48;5;20m",
        '#afafaf' => "\e[48;5;145m",
        '#afd700' => "\e[48;5;148m",
        '#af005f' => "\e[48;5;125m",
      }.map do |html_colour, terminal_colour|
        it 'translation is performed' do
          ColourTranslator.new(html_colour).background
            .must_equal(terminal_colour)
        end
      end

      it 'returns empty string when not present' do
        ColourTranslator.new.background.must_equal('')
      end

      it 'returns empty string when the wrong type!' do
        ColourTranslator.new(:wrong_type).background.must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.new('345678').background.must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.new('#h11111').background.must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.new('#1111').background.must_equal('')
      end
    end

    describe '#foreground' do
      {
        '#5f0000' => "\e[38;5;52m",
        '#008700' => "\e[38;5;28m",
        '#0000d7' => "\e[38;5;20m",
        '#afafaf' => "\e[38;5;145m",
        '#afd700' => "\e[38;5;148m",
        '#af005f' => "\e[38;5;125m",
      }.map do |html_colour, terminal_colour|
        it 'translation is performed' do
          ColourTranslator.new(html_colour).foreground
            .must_equal(terminal_colour)
        end
      end

      it 'returns empty string when not present' do
        ColourTranslator.new.foreground.must_equal('')
      end

      it 'returns empty string when the wrong type!' do
        ColourTranslator.new(:wrong_type).foreground.must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.new('345678').foreground.must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.new('#h11111').foreground.must_equal('')
      end

      it 'returns empty string when invalid format' do
        ColourTranslator.new('#1111').foreground.must_equal('')
      end
    end
  end
end
