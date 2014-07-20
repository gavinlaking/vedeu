require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/support/exit'

module Vedeu
  describe Exit do
    describe '.dispatch' do
      it 'halts execution' do
        proc { Exit.dispatch }.must_raise(StopIteration)
      end
    end
  end
end
