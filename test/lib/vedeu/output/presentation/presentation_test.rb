require 'test_helper'

module Vedeu

  class ParentPresentationTestClass
    include Vedeu::Presentation

    def parent
      nil
    end

    def attributes
      {
        colour: { background: '#330000', foreground: '#00aadd' },
        style:  ['bold']
      }
    end
  end

  class PresentationTestClass
    include Vedeu::Presentation

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def parent
      Vedeu::ParentPresentationTestClass.new
    end

  end # PresentationTestClass

  describe Presentation do

    let(:includer) { Vedeu::PresentationTestClass.new(attributes) }
    let(:attributes) {
      {
        colour: { background: background, foreground: foreground },
        style:  ['bold']
      }
    }
    let(:background) { '#000033' }
    let(:foreground) { '#aadd00' }

    describe '#to_s' do
      let(:red)   {
        Vedeu::Colours::Colour.new(foreground: '#ff0000', background: '#000000')
      }
      let(:green) {
        Vedeu::Colours::Colour.new(foreground: '#00ff00', background: '#000000')
      }
      let(:line) {
        Vedeu::Views::Line.new(value:  [],
                               parent: Vedeu::Interfaces::Interface.new,
                               colour: green,
                               style:  Vedeu::Presentation::Style.new('normal'))
      }
      let(:stream) {
        Vedeu::Views::Stream.new(value:  stream_value,
                                 parent: line,
                                 colour: red,
                                 style:  stream_style)
      }
      let(:stream_value)  { 'Some text' }
      let(:stream_style)  { Vedeu::Presentation::Style.new(:underline) }

      it { includer.must_respond_to(:to_str) }

      it 'returns output' do
        stream.to_s.must_equal(
          # - stream colour
          # - stream style
          # - stream content
          "\e[38;2;255;0;0m\e[48;2;0;0;0m"  \
          "\e[4m"                           \
          'Some text'
        )
      end
    end

  end # Presentation

end # Vedeu
