require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/presentation'

module Vedeu
  class TestPresentation
    include Presentation
  end

  describe Presentation do
    let(:described_module)   { Presentation }
    let(:described_instance) { TestPresentation.new(attributes) }
    let(:attributes) {
      {
        colour: {},
        style:  ['bold', 'underline']
      }
    }

    describe '#colour' do
      let(:subject) { described_instance.colour }

      it 'returns a Colour instance' do
        subject.must_be_instance_of(Colour)
      end
    end

    describe '#style' do
      let(:subject) { described_instance.style }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'has a style attribute' do
        subject.must_equal("\e[1m\e[4m")
      end
    end
  end
end
