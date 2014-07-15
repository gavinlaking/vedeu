require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/presentation'

module Vedeu
  class TestPresentation
    include Presentation
  end

  describe Presentation do
    describe '#colour' do
      it 'returns a Colour instance' do
        TestPresentation.new({
          colour: { foreground: '#ff0000', background: '#333333' }
        }).colour.must_be_instance_of(Colour)
      end
    end

    describe '#style' do
      it 'has a style attribute' do
        TestPresentation.new({
          style:  ['bold', 'underline']
        }).style.must_equal("\e[1m\e[4m")
      end
    end
  end
end
