# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Actions do

      let(:described) { Vedeu::EscapeSequences::Actions }

      describe '.hide_cursor' do
        it { described.hide_cursor.must_equal("\e[?25l") }
      end

      describe '.show_cursor' do
        it { described.show_cursor.must_equal("\e[?25h") }
      end

      describe '.cursor_position' do
        it { described.cursor_position.must_equal("\e[6n") }
      end

      describe '.bg_reset' do
        it { described.bg_reset.must_equal("\e[49m") }
      end

      describe '.blink' do
        it { described.blink.must_equal("\e[5m") }
      end

      describe '.blink_off' do
        it { described.blink_off.must_equal("\e[25m") }
      end

      describe '.bold' do
        it { described.bold.must_equal("\e[1m") }
      end

      describe '.bold_off' do
        it { described.bold_off.must_equal("\e[22m") }
      end

      describe '.dim' do
        it { described.dim.must_equal("\e[2m") }
      end

      describe '.fg_reset' do
        it { described.fg_reset.must_equal("\e[39m") }
      end

      describe '.negative' do
        it { described.negative.must_equal("\e[7m") }
      end

      describe '.positive' do
        it { described.positive.must_equal("\e[27m") }
      end

      describe '.reset' do
        it { described.reset.must_equal("\e[0m") }
      end

      describe '.underline' do
        it { described.underline.must_equal("\e[4m") }
      end

      describe '.underline_off' do
        it { described.underline_off.must_equal("\e[24m") }
      end

    end # Actions

  end # EscapeSequences

end # Vedeu
