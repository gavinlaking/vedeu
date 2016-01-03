# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Colours

    describe Foreground do

      let(:described) { Vedeu::Colours::Foreground }
      let(:instance)  { described.new(colour) }
      let(:colour)    {}

      before { Vedeu.foreground_colours.reset! }

      describe '#escape_sequence' do
        subject { instance.escape_sequence }

        context 'when the colour is empty' do
          let(:colour) { '' }

          it { subject.must_equal('') }
        end

        context 'when the colour is named (3-bit / 8 colours)' do
          {
            red:     "\e[31m",
            default: "\e[39m",
            unknown: '',
          }.map do |colour, result|
            it "returns the correct escape sequence for #{colour}" do
              described.new(colour).escape_sequence.must_equal(result)
            end
          end
        end

        context 'when the colour is numbered (8-bit / 256 colours)' do
          {
            82  => "\e[38;5;82m",
            -2  => '',
            442 => ''
          }.map do |colour, result|
            it "returns the correct escape sequence for #{colour}" do
              described.new(colour).escape_sequence.must_equal(result)
            end
          end
        end

        context 'when the colour is a CSS value (8-bit / 256 colours)' do
          before { Configuration.stubs(:colour_mode).returns(256) }

          {
            '#afd700' => "\e[38;5;148m",
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
            '#afd700' => "\e[38;2;175;215;0m",
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

      describe '#foreground?' do
        subject { instance.foreground? }

        context 'when the colour is empty' do
          let(:colour) {}

          it { subject.must_equal(false) }
        end

        context 'when the colour is not empty' do
          let(:colour) { '#afd700' }

          it { subject.must_equal(true) }
        end
      end

      describe '#to_h' do
        subject { instance.to_h }

        it { subject.must_be_instance_of(Hash) }

        context 'when the colour is empty' do
          let(:colour) {}
          let(:expected) {
            {
              foreground: ''
            }
          }

          it { subject.must_equal(expected) }
        end

        context 'when the colour is not empty' do
          let(:colour) { '#afd700' }
          let(:expected) {
            {
              foreground: '#afd700'
            }
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#to_hash' do
        it { instance.must_respond_to(:to_hash) }
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

          it 'returns the colour as a CSS property' do
            subject.must_equal('color:#afd700;')
          end
        end
      end

    end # Foreground

  end # Colours

end # Vedeu
