# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Templating

    describe ViewTemplate do

      let(:described) { Vedeu::Templating::ViewTemplate }
      let(:instance)  { described.new(object, path, options) }
      let(:object)    {}
      let(:path)      { Dir.tmpdir + '/some_template.erb' }
      let(:options)   { {} }
      let(:content)   { '' }

      describe '.parse' do
        before do
          File.stubs(:exist?).returns(true)
          File.stubs(:read).returns(content)
        end

        subject { described.parse(object, path) }

        context 'with a plain text file' do
          let(:content) { "This is a test.\n" }
          let(:expected) {
            Vedeu::Views::Lines.new([
              Vedeu::Views::Line.new(value:
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: 'This is a test.'))
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a plain text file with multiple lines' do
          let(:content) { "This is a test.\nAnd so is this.\n" }
          let(:expected) {
            Vedeu::Views::Lines.new([
              Vedeu::Views::Line.new(value:
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: 'This is a test.')),
              Vedeu::Views::Line.new(value:
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                           style: :normal,
                                         value: 'And so is this.')),
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a background colour directive' do
          let(:content) {
            "This is a <%= background('#ff0000') { 'test' } %>.\n"
          }
          let(:colour) {
            Vedeu::Colours::Colour.new(background: '#ff0000', foreground: '')
          }

          let(:expected) {
            Vedeu::Views::Lines.new([
              Vedeu::Views::Line.new(value: [
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: 'This is a '),
                Vedeu::Views::Stream.new(value: 'test', colour: colour),
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: '.'),
              ])
            ])
          }

          it { subject.must_equal(expected) }

          context 'and multiple' do
            let(:content) {
              "This is a <%= background('#ff0000') { 'test' } %>. And so is " \
              "<%= background('#ff0000') { 'this' } %>.\n"
            }

            let(:colour) {
              Vedeu::Colours::Colour.new(background: '#ff0000', foreground: '')
            }

            let(:expected) {
              Vedeu::Views::Lines.new([
                Vedeu::Views::Line.new(value: [
                  Vedeu::Views::Stream.new(colour: {
                                             background: :default,
                                             foreground: :default },
                                           style: :normal,
                                           value: 'This is a '),
                  Vedeu::Views::Stream.new(value: 'test', colour: colour),
                  Vedeu::Views::Stream.new(colour: {
                                             background: :default,
                                             foreground: :default },
                                           style: :normal,
                                           value: '. And so is '),
                  Vedeu::Views::Stream.new(value: 'this', colour: colour),
                  Vedeu::Views::Stream.new(colour: {
                                             background: :default,
                                             foreground: :default },
                                           style: :normal,
                                           value: '.'),
                ])
              ])
            }

            it { subject.must_equal(expected) }
          end
        end

        context 'with a foreground colour directive' do
          let(:content) {
            "This is a <%= foreground('#00ff00') { 'test' } %>.\n"
          }
          let(:colour) {
            Vedeu::Colours::Colour.new(background: '', foreground: '#00ff00')
          }

          let(:expected) {
            Vedeu::Views::Lines.new([
              Vedeu::Views::Line.new(value: [
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: 'This is a '),
                Vedeu::Views::Stream.new(value: 'test', colour: colour),
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: '.'),
              ])
            ])
          }

          it { subject.must_equal(expected) }
        end

        context 'with a colour directive' do
          let(:content) {
            "This is a <%= colour(background: '#003300', foreground: '#aadd00') { 'test' } %>.\n"
          }
          let(:colour) {
            Vedeu::Colours::Colour.new(background: '#003300', foreground: '#aadd00')
          }

          let(:expected) {
            Vedeu::Views::Lines.new([
              Vedeu::Views::Line.new(value: [
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: 'This is a '),
                Vedeu::Views::Stream.new(value: 'test', colour: colour),
                Vedeu::Views::Stream.new(colour: {
                                           background: :default,
                                           foreground: :default },
                                         style: :normal,
                                         value: '.'),
              ])
            ])
          }

          it { subject.must_equal(expected) }
        end

        # context 'with a style directive' do
        #   let(:content) { "This is a <%= style(:bold) { 'test' } %>." }
        #   let(:style) {
        #     Vedeu::Presentation::Style.new(:bold)
        #   }

        #   let(:expected) {
        #     Vedeu::Views::Lines.new([
        #       Vedeu::Views::Line.new(value: [
        #         Vedeu::Views::Stream.new(colour: {
        #                                    background: :default,
        #                                    foreground: :default },
        #                                  style: :normal,
        #                                  value: 'This is a '),
        #         Vedeu::Views::Stream.new(value: 'test', style: style),
        #         Vedeu::Views::Stream.new(colour: {
        #                                    background: :default,
        #                                    foreground: :default },
        #                                  style: :normal,
        #                                  value: '.'),
        #       ])
        #     ])
        #   }

        #   it { subject.must_equal(expected) }
        # end
      end

      describe '#parse' do
        it { instance.must_respond_to(:parse) }
      end

    end # ViewTemplate

  end # Templating

end # Vedeu
