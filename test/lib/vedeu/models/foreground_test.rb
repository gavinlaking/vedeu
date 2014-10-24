require 'test_helper'

module Vedeu

  describe Foreground do

    describe '.escape_sequence' do
      describe 'when the colour is empty' do
        it 'returns an empty String' do
          Foreground.escape_sequence('').must_equal('')
        end
      end

      describe 'when the colour is named (3-bit / 8 colours)' do
        {
          red:     "\e[31m",
          yellow:  "\e[33m",
          magenta: "\e[35m",
          white:   "\e[37m",
          default: "\e[39m",
          unknown: '',
        }.map do |colour, result|
          it "returns the correct escape sequence for #{colour}" do
            Foreground.escape_sequence(colour).must_equal(result)
          end
        end
      end

      describe 'when the colour is numbered (8-bit / 256 colours)' do
        {
          24  => "\e[38;5;24m",
          56  => "\e[38;5;56m",
          82  => "\e[38;5;82m",
          118 => "\e[38;5;118m",
          143 => "\e[38;5;143m",
          219 => "\e[38;5;219m",
          -2  => '',
          442 => ''
        }.map do |colour, result|
          it "returns the correct escape sequence for #{colour}" do
            Foreground.escape_sequence(colour).must_equal(result)
          end
        end
      end

      describe 'when the colour is a CSS value (8-bit / 256 colours)' do
        before { Configuration.stubs(:colour_mode).returns(8) }

        {
          '#5f0000' => "\e[38;5;52m",
          '#008700' => "\e[38;5;28m",
          '#0000d7' => "\e[38;5;20m",
          '#afafaf' => "\e[38;5;145m",
          '#afd700' => "\e[38;5;148m",
          '#af005f' => "\e[38;5;125m",
          '999999'  => '',
          '#12121'  => '',
          '#h11111' => '',
        }.map do |colour, result|
          it "returns the correct escape sequence for #{colour}" do
            Foreground.escape_sequence(colour).must_equal(result)
          end
        end
      end

      describe 'when the colour is a CSS value (24-bit / 16.8mil colours)' do
        {
          '#5f0000' => "\e[38;2;95;0;0m",
          '#008700' => "\e[38;2;0;135;0m",
          '#0000d7' => "\e[38;2;0;0;215m",
          '#afafaf' => "\e[38;2;175;175;175m",
          '#afd700' => "\e[38;2;175;215;0m",
          '#af005f' => "\e[38;2;175;0;95m",
          '999999'  => '',
          '#12121'  => '',
          '#h11111' => '',
        }.map do |colour, result|
          it "returns the correct escape sequence for #{colour}" do
            Foreground.escape_sequence(colour).must_equal(result)
          end
        end
      end
    end

  end # Foreground

end # Vedeu
