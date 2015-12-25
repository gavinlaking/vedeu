# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Borders do

      let(:described) { Vedeu::EscapeSequences::Borders }

      describe '.border_off' do
        it { described.border_off.must_equal("\e(B") }
      end

      describe '.border_on' do
        it { described.border_on.must_equal("\e(0") }
      end

      describe '.bottom_left' do
        it { described.bottom_left.must_equal("\x6D") }
      end

      describe '.bottom_right' do
        it { described.bottom_right.must_equal("\x6A") }
      end

      describe '.horizontal' do
        it { described.horizontal.must_equal("\x71") }
      end

      describe '.horizontal_bottom' do
        it { described.horizontal_bottom.must_equal("\x76") }
      end

      describe '.horizontal_top' do
        it { described.horizontal_top.must_equal("\x77") }
      end

      describe '.top_left' do
        it { described.top_left.must_equal("\x6C") }
      end

      describe '.top_right' do
        it { described.top_right.must_equal("\x6B") }
      end

      describe '.vertical' do
        it { described.vertical.must_equal("\x78") }
      end

      describe '.vertical_left' do
        it { described.vertical_left.must_equal("\x74") }
      end

      describe '.vertical_right' do
        it { described.vertical_right.must_equal("\x75") }
      end

    end # Borders

  end # EscapeSequences

end # Vedeu
