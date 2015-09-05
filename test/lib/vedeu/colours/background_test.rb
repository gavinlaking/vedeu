require 'test_helper'

module Vedeu

  module Colours

    describe Background do

      let(:described) { Vedeu::Colours::Background }
      let(:instance)  { described.new(colour) }
      let(:colour)    {}

      before { Vedeu.background_colours.reset! }

      describe '#escape_sequence' do
        subject { instance.escape_sequence }

        context 'when the colour is empty' do
          let(:colour) { '' }

          it { subject.must_equal('') }
        end

        context 'when the colour is named (3-bit / 8 colours)' do
          {
            red:     "\e[41m",
            yellow:  "\e[43m",
            magenta: "\e[45m",
            white:   "\e[107m",
            default: "\e[49m",
            unknown: '',
          }.map do |colour, result|
            it "returns the correct escape sequence for #{colour}" do
              described.new(colour).escape_sequence.must_equal(result)
            end
          end
        end

        context 'when the colour is numbered (8-bit / 256 colours)' do
          {
            24  => "\e[48;5;24m",
            56  => "\e[48;5;56m",
            82  => "\e[48;5;82m",
            118 => "\e[48;5;118m",
            143 => "\e[48;5;143m",
            219 => "\e[48;5;219m",
            -2  => '',
            442 => ''
          }.map do |colour, result|
            it "returns the correct escape sequence for #{colour}" do
              described.new(colour).escape_sequence.must_equal(result)
            end
          end
        end

        context 'when the colour is a CSS value (8-bit / 256 colours)' do
          before { Vedeu::Configuration.stubs(:colour_mode).returns(8) }

          {
            '#5f0000' => "\e[48;5;52m",
            '#008700' => "\e[48;5;28m",
            '#0000d7' => "\e[48;5;20m",
            '#afafaf' => "\e[48;5;145m",
            '#afd700' => "\e[48;5;148m",
            '#af005f' => "\e[48;5;125m",
            '999999'  => '',
            '#12121'  => '',
            '#h11111' => '',
          }.map do |colour, result|
            it "returns the correct escape sequence for #{colour}" do
              described.new(colour).escape_sequence.must_equal(result)
            end
          end
        end

        context 'when the colour is a CSS value (24-bit / 16.8mil colours)' do
          {
            '#5f0000' => "\e[48;2;95;0;0m",
            '#008700' => "\e[48;2;0;135;0m",
            '#0000d7' => "\e[48;2;0;0;215m",
            '#afafaf' => "\e[48;2;175;175;175m",
            '#afd700' => "\e[48;2;175;215;0m",
            '#af005f' => "\e[48;2;175;0;95m",
            '999999'  => '',
            '#12121'  => '',
            '#h11111' => '',
          }.map do |colour, result|
            it "returns the correct escape sequence for #{colour}" do
              described.new(colour).escape_sequence.must_equal(result)
            end
          end
        end
      end

      describe '.to_html' do
        subject { instance.to_html }

        context 'when the colour is empty' do
          let(:colour) {}

          it { subject.must_equal('') }
        end

        context 'when the colour is named (3-bit / 8 colours)' do
          let(:colour) { :red }

          it { subject.must_equal('') }
        end

        context 'when the colour is numbered (8-bit / 256 colours)' do
          let(:colour) { 118 }

          it { subject.must_equal('') }
        end

        context 'when the colour is a CSS value' do
          let(:colour) { '#afd700' }

          it 'returns the colour as a CSS value' do
            subject.must_equal('#afd700')
          end
        end
      end

    end # Background

  end # Colours

end # Vedeu
