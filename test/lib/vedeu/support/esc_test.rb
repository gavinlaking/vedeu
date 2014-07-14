require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/esc'

module Vedeu
  describe Esc do
    let(:described_class) { Esc }

    describe '.background_colour' do
      let(:subject) { described_class.background_colour }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[48;5;16m")
      end
    end

    describe '.clear_line' do
      let(:subject) { described_class.clear_line }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[2K")
      end
    end

    describe '.foreground_colour' do
      let(:subject) { described_class.foreground_colour }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[38;5;231m")
      end
    end

    describe '.set_position' do
      let(:subject) { described_class.set_position(y, x) }
      let(:y)       {}
      let(:x)       {}

      context 'when no coordinates are provided' do
        it 'returns a position escape sequence' do
          subject.must_equal("\e[1;1H")
        end
      end

      context 'when coordinates are provided' do
        let(:y)       { 12 }
        let(:x)       { 19 }

        it 'returns a position escape sequence' do
          subject.must_equal("\e[12;19H")
        end
      end
    end

    describe '.string' do
      let(:subject) { described_class.string(style) }
      let(:style)   {}

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'when the style is not provided' do
        it 'returns an empty string' do
          subject.must_equal('')
        end
      end

      context 'when the style is blink' do
        let(:style) { 'blink' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[5m")
        end
      end

      context 'when the style is blink off' do
        let(:style) { 'blink_off' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[25m")
        end
      end

      context 'when the style is bold' do
        let(:style) { 'bold' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[1m")
        end
      end

      context 'when the style is bold off' do
        let(:style) { 'bold_off' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[21m")
        end
      end

      context 'when the style is clear' do
        let(:style) { 'clear' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[2J")
        end
      end

      context 'when the style is colour_reset' do
        let(:style) { 'colour_reset' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[38;2;39m\e[48;2;49m")
        end
      end

      context 'when the style is hide_cursor' do
        let(:style) { 'hide_cursor' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[?25l")
        end
      end

      context 'when the style is negative' do
        let(:style) { 'negative' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[7m")
        end
      end

      context 'when the style is positive' do
        let(:style) { 'positive' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[27m")
        end
      end

      context 'when the style is reset' do
        let(:style) { 'reset' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[0m")
        end
      end

      context 'when the style is normal' do
        let(:style) { 'normal' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[24m\e[21m\e[27m")
        end
      end

      context 'when the style is dim' do
        let(:style) { 'dim' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[2m")
        end
      end

      context 'when the style is show_cursor' do
        let(:style) { 'show_cursor' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[?25h")
        end
      end

      context 'when the style is underline' do
        let(:style) { 'underline' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[4m")
        end
      end

      context 'when the style is underline off' do
        let(:style) { 'underline_off' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[24m")
        end
      end
    end
  end
end
