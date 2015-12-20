require 'test_helper'

module Vedeu

  module Colours

    describe Background do

      let(:described) { Vedeu::Colours::Background }
      let(:instance)  { described.new(colour) }
      let(:colour)    {}

      before { Vedeu.background_colours.reset! }

      describe '#background?' do
        subject { instance.background? }

        context 'when the colour is empty' do
          let(:colour) {}

          it { subject.must_equal(false) }
        end

        context 'when the colour is not empty' do
          let(:colour) { '#afd700' }

          it { subject.must_equal(true) }
        end
      end

      describe '#escape_sequence' do
        subject { instance.escape_sequence }

        context 'when the colour is empty' do
          let(:colour) { '' }

          it { subject.must_equal('') }
        end

        context 'when the colour is named (3-bit / 8 colours)' do
          {
            magenta: "\e[45m",
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
            118 => "\e[48;5;118m",
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
            '#0000d7' => "\e[48;5;20m",
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
            '#0000d7' => "\e[48;2;0;0;215m",
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

      describe '#to_html' do
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
