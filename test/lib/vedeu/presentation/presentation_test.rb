# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class ParentPresentationTestClass

    include Vedeu::Presentation
    include Vedeu::Presentation::Colour
    include Vedeu::Presentation::Position
    include Vedeu::Presentation::Styles

    def parent
      nil
    end

    def attributes
      {
        colour: { background: '#330000', foreground: '#00aadd' },
        style:  ['bold']
      }
    end

  end # ParentPresentationTestClass

  class PresentationTestClass

    include Vedeu::Presentation
    include Vedeu::Presentation::Colour
    include Vedeu::Presentation::Position
    include Vedeu::Presentation::Styles

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def parent
      Vedeu::ParentPresentationTestClass.new
    end

  end # PresentationTestClass

  describe Presentation do

    let(:described)          { Vedeu::Presentation }
    let(:included_described) { Vedeu::PresentationTestClass }
    let(:included_instance)  { included_described.new(attributes) }
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
      let(:expected) {
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4m" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4mS" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4mo" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4mm" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4me" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4m " \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4mt" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4me" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4mx" \
        "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[4mt"
      }

      it { included_instance.must_respond_to(:to_str) }

      it 'returns output' do
        stream.to_s.must_equal(expected)
      end
    end

  end # Presentation

end # Vedeu
