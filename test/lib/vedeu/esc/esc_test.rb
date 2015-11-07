require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Esc do

      let(:described) { Vedeu::EscapeSequences::Esc }

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

      describe '.border' do
        context 'when the block is given' do
          it { described.border { 'b' }.must_equal("\e(0b\e(B") }
        end

        context 'when the block is not given' do
          it { described.border.must_equal('') }
        end
      end

      describe '.string' do
        context 'when the style is not provided' do
          it { described.string.must_equal('') }
        end

        context 'when the style is provided' do
          it { described.string('bg_reset').must_equal("\e[49m") }
          it { described.string('blink').must_equal("\e[5m") }
          it { described.string('blink_off').must_equal("\e[25m") }
          it { described.string('bold').must_equal("\e[1m") }
          it { described.string('bold_off').must_equal("\e[22m") }
          it { described.string('clear').must_equal("\e[39m\e[49m\e[2J") }
          it { described.string('clear_line').must_equal("\e[39m\e[49m\e[2K") }
          it { described.string('colour_reset').must_equal("\e[39m\e[49m") }
          it { described.string('screen_colour_reset').must_equal("\e[39m\e[49m") }
          it { described.string('fg_reset').must_equal("\e[39m") }
          it { described.string('hide_cursor').must_equal("\e[?25l") }
          it { described.string('screen_init').
                 must_equal("\e[0m\e[39m\e[49m\e[2J\e[?25l\e[?9h\e[?1000h") }
          it { described.string('negative').must_equal("\e[7m") }
          it { described.string('positive').must_equal("\e[27m") }
          it { described.string('reset').must_equal("\e[0m") }
          it { described.string('normal').must_equal("\e[24m\e[22m\e[27m") }
          it { described.string('dim').must_equal("\e[2m") }
          it { described.string('show_cursor').must_equal("\e[?25h") }
          it { described.string('underline').must_equal("\e[4m") }
          it { described.string('underline_off').must_equal("\e[24m") }
          it { described.string('cursor_position').must_equal("\e[6n") }
        end

        context 'screen_exit' do
          before { Vedeu::Terminal.stubs(:size).returns([80, 25]) }

          it { described.string('screen_exit').
                 must_equal("\e[?9l\e[?1000l\e[?25h\e[39m\e[49m\e[0m\e[80;25H\n") }
        end
      end

    end # Esc

  end # EscapeSequences

end # Vedeu
