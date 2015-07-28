require 'test_helper'

module Vedeu

  module Templating

  	describe ViewTemplate do

      let(:described) { Vedeu::Templating::ViewTemplate }
      let(:instance)  { described.new(object, path) }
      let(:object)    {}
      let(:path)      {}

      describe '.parse' do
        let(:path) { 'test/support/templates/plain.erb' }

        subject { described.parse(object, path) }

        it {
          Vedeu::Templating::PostProcessor.expects(:process).
            with("This is a test.\n")
          subject
        }

        context 'with a plain text file' do
          let(:path) { 'test/support/templates/plain.erb' }
          let(:expected) {
            Vedeu::Streams.new.add(Vedeu::Stream.new(value: "This is a test."))
          }

          it { subject.must_equal(expected) }
        end

        context 'with a background colour directive' do
          let(:path) { 'test/support/templates/background.erb' }

          let(:expected) {
            Vedeu::Streams.new([
              Vedeu::Stream.new({
                value: 'This is a '
              }),
              Vedeu::Stream.new({
                colour: Vedeu::Colour.coerce({ background: '#ff0000' }),
                value: 'test'
              }),
              Vedeu::Stream.new({
                value: '.'
              })
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a foreground colour directive' do
          let(:path) { 'test/support/templates/foreground.erb' }

          let(:expected) {
            Vedeu::Streams.new([
              Vedeu::Stream.new({
                value: 'This is a '
              }),
              Vedeu::Stream.new({
                colour: Vedeu::Colour.coerce({ foreground: '#00ff00' }),
                value: 'test'
              }),
              Vedeu::Stream.new({
                value: '.'
              })
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a colour directive' do
          let(:path) { 'test/support/templates/colour.erb' }

          let(:expected) {
            Vedeu::Streams.new([
              Vedeu::Stream.new({
                value: 'This is a '
              }),
              Vedeu::Stream.new({
                colour: Vedeu::Colour.coerce({ background: '#003300', foreground: '#aadd00' }),
                value: 'test'
              }),
              Vedeu::Stream.new({
                value: '.'
              })
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a style directive' do
          let(:path) { 'test/support/templates/style.erb' }

          let(:expected) {
            Vedeu::Streams.new([
              Vedeu::Stream.new({
                value: 'This is a '
              }),
              Vedeu::Stream.new({
                style: Vedeu::Style.coerce(:bold),
                value: 'test'
              }),
              Vedeu::Stream.new({
                value: '.'
              })
            ])
          }

          it { subject.must_equal(expected) }
        end
      end

  	end # ViewTemplate

  end # Templating

end # Vedeu
