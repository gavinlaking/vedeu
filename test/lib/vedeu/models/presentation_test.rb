require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/presentation'

module Vedeu
  class TestPresentation
    include Presentation
  end

  describe Presentation do
    let(:presentation) {
      TestPresentation.new({
        colour: {
          foreground: '#ff0000',
          background: '#333333'
        },
        style: ['bold', 'underline']
      })
    }

    describe '#colour' do
      it 'returns a Colour instance' do
        presentation.colour.must_be_instance_of(Colour)
      end
    end

    describe '#style' do
      it 'has a style attribute' do
        presentation.style.must_equal(['bold', 'underline'])
      end
    end
  end
end
