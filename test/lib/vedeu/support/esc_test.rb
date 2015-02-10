require 'test_helper'

module Vedeu

  describe Esc do

    describe 'colours defined via define_method' do
      it 'returns an escape sequence for the foreground colour' do
        Esc.magenta.must_equal("\e[35m")
      end

      it 'returns an escape sequence for the foreground colour and resets ' \
         'after calling the block' do
        Esc.cyan do
          'ununpentium'
        end.must_equal("\e[36mununpentium\e[39m")
      end

      it 'returns an escape sequence for the background colour' do
        Esc.on_yellow.must_equal("\e[43m")
      end

      it 'returns an escape sequence for the background colour and resets ' \
         'after calling the block' do
        Esc.on_red do
          'livermorium'
        end.must_equal("\e[41mlivermorium\e[49m")
      end
    end

    describe '.escape' do
      let(:stream) { "\e[0m\e[38;2;39m\e[48;2;49m\e[2J\e[?25l" }

      subject { Esc.escape(stream) }

      it { subject.must_be_instance_of(String) }

      it 'escapes the escape sequences' do
        subject.must_equal('\e[0m\e[38;2;39m\e[48;2;49m\e[2J\e[?25l')
      end

      context 'when a stream is not given' do
        let(:stream) { '' }

        it { Esc.escape(stream).must_equal('') }
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
        Esc.string('bold_off').must_equal("\e[22m")
      end

      it 'returns an escape sequence when the style is clear' do
        Esc.string('clear').must_equal("\e[38;2;39m\e[48;2;49m\e[2J")
      end

      it 'returns an escape sequence when the style is clear_line' do
        Esc.string('clear_line').must_equal("\e[38;2;39m\e[48;2;49m\e[2K")
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

      it 'returns an escape sequence when the style is screen_init' do
        Esc.string('screen_init').must_equal("\e[0m\e[38;2;39m\e[48;2;49m\e[2J\e[?25l")
      end

      it 'returns an escape sequence when the style is screen_exit' do
        Esc.string('screen_exit').must_equal("\e[?25h\e[38;2;39m\e[48;2;49m\e[0m")
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
        Esc.string('normal').must_equal("\e[24m\e[22m\e[27m")
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

  end # Esc

end # Vedeu
