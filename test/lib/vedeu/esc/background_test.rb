# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Background do

      let(:described) { Vedeu::EscapeSequences::Background }

      describe '.on_black' do
        context 'when a block is given' do
          it { described.on_black { 'test' }.must_equal("\e[40mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_black.must_equal("\e[40m") }
        end
      end

      describe '.on_red' do
        context 'when a block is given' do
          it { described.on_red { 'test' }.must_equal("\e[41mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_red.must_equal("\e[41m") }
        end
      end

      describe '.on_green' do
        context 'when a block is given' do
          it { described.on_green { 'test' }.must_equal("\e[42mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_green.must_equal("\e[42m") }
        end
      end

      describe '.on_yellow' do
        context 'when a block is given' do
          it { described.on_yellow { 'test' }.must_equal("\e[43mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_yellow.must_equal("\e[43m") }
        end
      end

      describe '.on_blue' do
        context 'when a block is given' do
          it { described.on_blue { 'test' }.must_equal("\e[44mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_blue.must_equal("\e[44m") }
        end
      end

      describe '.on_magenta' do
        context 'when a block is given' do
          it { described.on_magenta { 'test' }.must_equal("\e[45mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_magenta.must_equal("\e[45m") }
        end
      end

      describe '.on_cyan' do
        context 'when a block is given' do
          it { described.on_cyan { 'test' }.must_equal("\e[46mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_cyan.must_equal("\e[46m") }
        end
      end

      describe '.on_light_grey' do
        context 'when a block is given' do
          it { described.on_light_grey { 'test' }.must_equal("\e[47mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_light_grey.must_equal("\e[47m") }
        end
      end

      describe '.on_default' do
        context 'when a block is given' do
          it { described.on_default { 'test' }.must_equal("\e[49mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_default.must_equal("\e[49m") }
        end
      end

      describe '.on_dark_grey' do
        context 'when a block is given' do
          it { described.on_dark_grey { 'test' }.must_equal("\e[100mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_dark_grey.must_equal("\e[100m") }
        end
      end

      describe '.on_light_red' do
        context 'when a block is given' do
          it { described.on_light_red { 'test' }.must_equal("\e[101mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_light_red.must_equal("\e[101m") }
        end
      end

      describe '.on_light_green' do
        context 'when a block is given' do
          it { described.on_light_green { 'test' }.must_equal("\e[102mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_light_green.must_equal("\e[102m") }
        end
      end

      describe '.on_light_yellow' do
        context 'when a block is given' do
          it { described.on_light_yellow { 'test' }.must_equal("\e[103mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_light_yellow.must_equal("\e[103m") }
        end
      end

      describe '.on_light_blue' do
        context 'when a block is given' do
          it { described.on_light_blue { 'test' }.must_equal("\e[104mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_light_blue.must_equal("\e[104m") }
        end
      end

      describe '.on_light_magenta' do
        context 'when a block is given' do
          it { described.on_light_magenta { 'test' }.must_equal("\e[105mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_light_magenta.must_equal("\e[105m") }
        end
      end

      describe '.on_light_cyan' do
        context 'when a block is given' do
          it { described.on_light_cyan { 'test' }.must_equal("\e[106mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_light_cyan.must_equal("\e[106m") }
        end
      end

      describe '.on_white' do
        context 'when a block is given' do
          it { described.on_white { 'test' }.must_equal("\e[107mtest\e[49m") }
        end

        context 'when a block is not given' do
          it { described.on_white.must_equal("\e[107m") }
        end
      end

    end # Background

  end # EscapeSequences

end # Vedeu
