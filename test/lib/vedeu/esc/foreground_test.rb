# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Foreground do

      let(:described) { Vedeu::EscapeSequences::Foreground }

      describe '.black' do
        context 'when a block is given' do
          it { described.black { 'test' }.must_equal("\e[30mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.black.must_equal("\e[30m") }
        end
      end

      describe '.red' do
        context 'when a block is given' do
          it { described.red { 'test' }.must_equal("\e[31mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.red.must_equal("\e[31m") }
        end
      end

      describe '.green' do
        context 'when a block is given' do
          it { described.green { 'test' }.must_equal("\e[32mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.green.must_equal("\e[32m") }
        end
      end

      describe '.yellow' do
        context 'when a block is given' do
          it { described.yellow { 'test' }.must_equal("\e[33mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.yellow.must_equal("\e[33m") }
        end
      end

      describe '.blue' do
        context 'when a block is given' do
          it { described.blue { 'test' }.must_equal("\e[34mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.blue.must_equal("\e[34m") }
        end
      end

      describe '.magenta' do
        context 'when a block is given' do
          it { described.magenta { 'test' }.must_equal("\e[35mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.magenta.must_equal("\e[35m") }
        end
      end

      describe '.cyan' do
        context 'when a block is given' do
          it { described.cyan { 'test' }.must_equal("\e[36mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.cyan.must_equal("\e[36m") }
        end
      end

      describe '.light_grey' do
        context 'when a block is given' do
          it { described.light_grey { 'test' }.must_equal("\e[37mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.light_grey.must_equal("\e[37m") }
        end
      end

      describe '.default' do
        context 'when a block is given' do
          it { described.default { 'test' }.must_equal("\e[39mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.default.must_equal("\e[39m") }
        end
      end

      describe '.dark_grey' do
        context 'when a block is given' do
          it { described.dark_grey { 'test' }.must_equal("\e[90mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.dark_grey.must_equal("\e[90m") }
        end
      end

      describe '.light_red' do
        context 'when a block is given' do
          it { described.light_red { 'test' }.must_equal("\e[91mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.light_red.must_equal("\e[91m") }
        end
      end

      describe '.light_green' do
        context 'when a block is given' do
          it { described.light_green { 'test' }.must_equal("\e[92mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.light_green.must_equal("\e[92m") }
        end
      end

      describe '.light_yellow' do
        context 'when a block is given' do
          it { described.light_yellow { 'test' }.must_equal("\e[93mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.light_yellow.must_equal("\e[93m") }
        end
      end

      describe '.light_blue' do
        context 'when a block is given' do
          it { described.light_blue { 'test' }.must_equal("\e[94mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.light_blue.must_equal("\e[94m") }
        end
      end

      describe '.light_magenta' do
        context 'when a block is given' do
          it { described.light_magenta { 'test' }.must_equal("\e[95mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.light_magenta.must_equal("\e[95m") }
        end
      end

      describe '.light_cyan' do
        context 'when a block is given' do
          it { described.light_cyan { 'test' }.must_equal("\e[96mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.light_cyan.must_equal("\e[96m") }
        end
      end

      describe '.white' do
        context 'when a block is given' do
          it { described.white { 'test' }.must_equal("\e[97mtest\e[39m") }
        end

        context 'when a block is not given' do
          it { described.white.must_equal("\e[97m") }
        end
      end

    end # Foreground

  end # EscapeSequences

end # Vedeu
