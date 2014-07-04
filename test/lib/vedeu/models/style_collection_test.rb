require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/style_collection'
require_relative '../../../../lib/vedeu/models/stream'

module Vedeu
  describe StyleCollection do
    let(:described_class) { StyleCollection }

    describe '#coerce' do
      let(:subject) { Vedeu::Stream.new({ style: style }).style }
      let(:style)   {}

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an empty string' do
        subject.must_equal('')
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
