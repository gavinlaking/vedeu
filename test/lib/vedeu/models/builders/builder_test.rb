require_relative '../../../../test_helper'
require_relative '../../../../../lib/vedeu/models/builders/builder'

module Vedeu
  describe Builder do
    it 'raises an exception if not subclassed' do
      builder = Builder.new('builder_test')
      proc { builder.repository }.must_raise(StandardError)
    end
  end
end
