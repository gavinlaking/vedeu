require 'test_helper'

module Vedeu

  describe Esc do

    let(:described) { Vedeu::Esc }

    describe 'alias methods' do
      it { described.must_respond_to(:foreground_codes) }
    end

    describe 'colours defined via define_method' do
      it 'returns an escape sequence for the foreground colour' do
        described.magenta.must_equal("\e[35m")
      end

      it 'returns an escape sequence for the foreground colour and resets ' \
         'after calling the block' do
        described.cyan do
          'ununpentium'
        end.must_equal("\e[36mununpentium\e[39m")
      end

      it 'returns an escape sequence for the background colour' do
        described.on_yellow.must_equal("\e[43m")
      end

      it 'returns an escape sequence for the background colour and resets ' \
         'after calling the block' do
        described.on_red do
          'livermorium'
        end.must_equal("\e[41mlivermorium\e[49m")
      end
    end

    describe '.escape' do
      let(:stream) { "\e[0m\e[38;2;39m\e[48;2;49m\e[2J\e[?25l" }

      subject { described.escape(stream) }

      it { subject.must_be_instance_of(String) }

      it 'escapes the escape sequences' do
        subject.must_equal('\e[0m\e[38;2;39m\e[48;2;49m\e[2J\e[?25l')
      end

      context 'when a stream is not given' do
        let(:stream) { '' }

        it { subject.must_equal('') }
      end
    end

    describe '.hide_cursor' do
      subject { described.hide_cursor }

      it { subject.must_be_instance_of(String) }
      it { subject.must_equal("\e[?25l") }
    end

    describe '.show_cursor' do
      subject { described.show_cursor }

      it { subject.must_be_instance_of(String) }
      it { subject.must_equal("\e[?25h") }
    end

    describe '.string' do
      it 'returns an empty string when the style is not provided' do
        described.string.must_equal('')
      end

      it 'returns an escape sequence when the style is bg_reset' do
        described.string('bg_reset').must_equal("\e[49m")
      end

      it 'returns an escape sequence when the style is blink' do
        described.string('blink').must_equal("\e[5m")
      end

      it 'returns an escape sequence when the style is blink off' do
        described.string('blink_off').must_equal("\e[25m")
      end

      it 'returns an escape sequence when the style is bold' do
        described.string('bold').must_equal("\e[1m")
      end

      it 'returns an escape sequence when the style is bold off' do
        described.string('bold_off').must_equal("\e[22m")
      end

      it 'returns an escape sequence when the style is clear' do
        described.string('clear').must_equal("\e[39m\e[49m\e[2J")
      end

      it 'returns an escape sequence when the style is clear_line' do
        described.string('clear_line').must_equal("\e[39m\e[49m\e[2K")
      end

      it 'returns an escape sequence when the style is colour_reset' do
        described.string('colour_reset').must_equal("\e[39m\e[49m")
      end

      it 'returns an escape sequence when the style is fg_reset' do
        described.string('fg_reset').must_equal("\e[39m")
      end

      it 'returns an escape sequence when the style is hide_cursor' do
        described.string('hide_cursor').must_equal("\e[?25l")
      end

      it 'returns an escape sequence when the style is screen_init' do
        described.string('screen_init').must_equal("\e[0m\e[39m\e[49m\e[2J\e[?25l")
      end

      it 'returns an escape sequence when the style is screen_exit' do
        described.string('screen_exit').must_equal("\e[?25h\e[39m\e[49m\e[0m")
      end

      it 'returns an escape sequence when the style is negative' do
        described.string('negative').must_equal("\e[7m")
      end

      it 'returns an escape sequence when the style is positive' do
        described.string('positive').must_equal("\e[27m")
      end

      it 'returns an escape sequence when the style is reset' do
        described.string('reset').must_equal("\e[0m")
      end

      it 'returns an escape sequence when the style is normal' do
        described.string('normal').must_equal("\e[24m\e[22m\e[27m")
      end

      it 'returns an escape sequence when the style is dim' do
        described.string('dim').must_equal("\e[2m")
      end

      it 'returns an escape sequence when the style is show_cursor' do
        described.string('show_cursor').must_equal("\e[?25h")
      end

      it 'returns an escape sequence when the style is underline' do
        described.string('underline').must_equal("\e[4m")
      end

      it 'returns an escape sequence when the style is underline off' do
        described.string('underline_off').must_equal("\e[24m")
      end
    end

  end # Esc

end # Vedeu
