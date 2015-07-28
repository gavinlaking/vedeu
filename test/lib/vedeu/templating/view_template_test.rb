require 'test_helper'

module Vedeu

  module Templating

  	describe ViewTemplate do

      let(:described) { Vedeu::Templating::ViewTemplate }
      let(:instance)  { described.new(object, path) }
      let(:object)    {}
      let(:path)      {}

      describe '.parse' do
        subject { described.parse(object, path) }

        context 'with a plain text file' do
          let(:path) { 'test/support/templates/plain.erb' }

          let(:expected) {
            Vedeu::Lines.new([
              Vedeu::Line.new(streams: Vedeu::Stream.new(value: 'This is a test.'))
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a plain text file with multiple lines' do
          let(:path) { 'test/support/templates/multiple.erb' }

          let(:expected) {
            Vedeu::Lines.new([
              Vedeu::Line.new(streams: Vedeu::Stream.new(value: 'This is a test.')),
              Vedeu::Line.new(streams: Vedeu::Stream.new(value: 'And so is this.')),
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a background colour directive' do
          let(:path)   { 'test/support/templates/background.erb' }
          let(:colour) {
            Vedeu::Colour.new(background: '#ff0000', foreground: '')
          }

          let(:expected) {
            Vedeu::Lines.new([
              Vedeu::Line.new(streams: [
                Vedeu::Stream.new(value: 'This is a '),
                Vedeu::Stream.new(value: 'test', colour: colour),
                Vedeu::Stream.new(value: '.'),
              ])
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a foreground colour directive' do
          let(:path) { 'test/support/templates/foreground.erb' }
          let(:colour) {
            Vedeu::Colour.new(background: '', foreground: '#00ff00')
          }

          let(:expected) {
            Vedeu::Lines.new([
              Vedeu::Line.new(streams: [
                Vedeu::Stream.new(value: 'This is a '),
                Vedeu::Stream.new(value: 'test', colour: colour),
                Vedeu::Stream.new(value: '.'),
              ])
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a colour directive' do
          let(:path) { 'test/support/templates/colour.erb' }

          let(:colour) {
            Vedeu::Colour.new(background: '#003300', foreground: '#aadd00')
          }

          let(:expected) {
            Vedeu::Lines.new([
              Vedeu::Line.new(streams: [
                Vedeu::Stream.new(value: 'This is a '),
                Vedeu::Stream.new(value: 'test', colour: colour),
                Vedeu::Stream.new(value: '.'),
              ])
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a style directive' do
          let(:path) { 'test/support/templates/style.erb' }

          let(:style) {
            Vedeu::Style.new(:bold)
          }

          let(:expected) {
            Vedeu::Lines.new([
              Vedeu::Line.new(streams: [
                Vedeu::Stream.new(value: 'This is a '),
                Vedeu::Stream.new(value: 'test', style: style),
                Vedeu::Stream.new(value: '.'),
              ])
            ])
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#parse' do
        it { instance.must_respond_to(:parse) }
      end

  	end # ViewTemplate

  end # Templating

end # Vedeu
