require 'test_helper'

module Vedeu
  class PresentationTestClass
    include Presentation

    def attributes
      {
        colour: { background: '#000033', foreground: '#aadd00' },
        style:  ['bold']
      }
    end
  end # PresentationTestClass

  describe Presentation do

    let(:receiver) { PresentationTestClass.new }

    describe '#colour' do
      it 'returns a Colour instance' do
        receiver.colour.must_be_instance_of(Colour)
      end
    end

    describe '#style' do
      it 'returns a Style instance' do
        receiver.style.must_be_instance_of(Style)
      end
    end

    describe '#to_s' do
      it 'returns output' do
        line = Line.new({
          colour: {
            foreground: '#00ff00',
            background: '#000000'
          },
          style: 'normal'
        })
        stream = Stream.new({
          colour: {
            foreground: '#ff0000',
            background: '#000000'
          },
          text:  'Some text',
          style: 'underline',
          width: nil,
          align: :left,
          parent: line.view_attributes,
        })
        stream.to_s.must_equal(
          "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
          "\e[4m" \
          "Some text" \
          "\e[24m\e[22m\e[27m" \
          "\e[38;2;0;255;0m\e[48;2;0;0;0m"
        )
      end
    end

  end # Presentation

end # Vedeu
