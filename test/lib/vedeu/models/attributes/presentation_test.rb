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
  end

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
  end
end
