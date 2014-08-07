require 'test_helper'
require 'vedeu/support/esc'

module Vedeu
  describe Esc do
    describe '.set_position' do
      it 'returns a position escape sequence when no coordinates are provided' do
        Esc.set_position.must_equal("\e[1;1H")
      end

      it 'returns a position escape sequence when coordinates are provided' do
        Esc.set_position(12, 19).must_equal("\e[12;19H")
      end
    end

    describe '.string' do
      it 'returns an empty string when the style is not provided' do
        Esc.string.must_equal('')
      end

      it 'returns an escape sequence when the style is bg_reset' do
        Esc.string('bg_reset').must_equal("\e[48;2;49m")
      end

      it 'returns an escape sequence when the style is blink' do
        Esc.string('blink').must_equal("\e[5m")
      end

      it 'returns an escape sequence when the style is blink off' do
        Esc.string('blink_off').must_equal("\e[25m")
      end

      it 'returns an escape sequence when the style is bold' do
        Esc.string('bold').must_equal("\e[1m")
      end

      it 'returns an escape sequence when the style is bold off' do
        Esc.string('bold_off').must_equal("\e[21m")
      end

      it 'returns an escape sequence when the style is clear' do
        Esc.string('clear').must_equal("\e[2J")
      end

      it 'returns an escape sequence when the style is colour_reset' do
        Esc.string('colour_reset').must_equal("\e[38;2;39m\e[48;2;49m")
      end

      it 'returns an escape sequence when the style is fg_reset' do
        Esc.string('fg_reset').must_equal("\e[38;2;39m")
      end

      it 'returns an escape sequence when the style is hide_cursor' do
        Esc.string('hide_cursor').must_equal("\e[?25l")
      end

      it 'returns an escape sequence when the style is negative' do
        Esc.string('negative').must_equal("\e[7m")
      end

      it 'returns an escape sequence when the style is positive' do
        Esc.string('positive').must_equal("\e[27m")
      end

      it 'returns an escape sequence when the style is reset' do
        Esc.string('reset').must_equal("\e[0m")
      end

      it 'returns an escape sequence when the style is normal' do
        Esc.string('normal').must_equal("\e[24m\e[21m\e[27m")
      end

      it 'returns an escape sequence when the style is dim' do
        Esc.string('dim').must_equal("\e[2m")
      end

      it 'returns an escape sequence when the style is show_cursor' do
        Esc.string('show_cursor').must_equal("\e[?25h")
      end

      it 'returns an escape sequence when the style is underline' do
        Esc.string('underline').must_equal("\e[4m")
      end

      it 'returns an escape sequence when the style is underline off' do
        Esc.string('underline_off').must_equal("\e[24m")
      end
    end
  end
end
