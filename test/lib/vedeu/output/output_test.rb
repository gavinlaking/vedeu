require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/output/output'

module Vedeu
  describe Output do
    describe '.render' do
      it 'returns an Array' do
        Output.render.must_be_instance_of(Array)
      end
    end
  end
end
